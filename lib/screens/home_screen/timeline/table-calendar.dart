import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myapp/features/task/data/tasks_data.dart';
import 'package:myapp/features/task/data/tasks_list.dart';
import 'package:myapp/features/task/providers/task_provider.dart';
import 'package:myapp/features/task/repositories/tasks_repository.dart';
import 'package:myapp/screens/home_screen/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;

  const _CalendarHeader({
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
  });

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          SizedBox(
            width: 120.0,
            child: Text(
              headerText,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.calendar_today,
              size: 20.0,
              color: Colors.green,
            ),
            visualDensity: VisualDensity.compact,
            onPressed: onTodayButtonTap,
          ),
          if (clearButtonVisible)
            IconButton(
              icon: const Icon(
                Icons.clear,
                size: 20.0,
                color: Colors.red,
              ),
              visualDensity: VisualDensity.compact,
              onPressed: onClearButtonTap,
            ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}

class TimelineTableCalendar extends ConsumerStatefulWidget {
  const TimelineTableCalendar({super.key});

  @override
  ConsumerState<TimelineTableCalendar> createState() =>
      _TimelineTableCalendar();
}

class _TimelineTableCalendar extends ConsumerState<TimelineTableCalendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  late final Future<List<TasksListResponse>?> _taskList;

  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  late PageController _pageController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _taskList = ref.read(taskRepositoryProvider).getTaskList();
    _selectedDays.add(_focusedDay.value);
    _selectedEvents = ValueNotifier([]);
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<Event> _getEventsForDay(
      Map<DateTime, List<Event>> kEvents, DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(
      Map<DateTime, List<Event>> kEvents, Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(kEvents, d),
    ];
  }

  List<Event> _getEventsForRange(
      Map<DateTime, List<Event>> kEvents, DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return _getEventsForDays(kEvents, days);
  }

  void _onDaySelected(Map<DateTime, List<Event>> kEvents, DateTime selectedDay,
      DateTime focusedDay) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    _selectedEvents.value = _getEventsForDays(kEvents, _selectedDays);
  }

  void _onRangeSelected(Map<DateTime, List<Event>> kEvents, DateTime? start,
      DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay.value = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _selectedDays.clear();
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(kEvents, start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(kEvents, start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(kEvents, end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TasksListResponse>?>(
        future: _taskList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks available'));
          }

          final taskList = snapshot.data!;
          final _kEvents = kEvents(taskList[0].tasks);
          _selectedEvents.value = _getEventsForDay(_kEvents, _focusedDay.value);

          return Column(
            children: [
              ValueListenableBuilder<DateTime>(
                valueListenable: _focusedDay,
                builder: (context, value, _) {
                  return _CalendarHeader(
                    focusedDay: value,
                    clearButtonVisible: canClearSelection,
                    onTodayButtonTap: () {
                      setState(() => _focusedDay.value = DateTime.now());
                    },
                    onClearButtonTap: () {
                      setState(() {
                        _rangeStart = null;
                        _rangeEnd = null;
                        _selectedDays.clear();
                        _selectedEvents.value = [];
                      });
                    },
                    onLeftArrowTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    onRightArrowTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                  );
                },
              ),
              TableCalendar<Event>(
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (BuildContext context, date, events) {
                    if (events.isEmpty) return const SizedBox();
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(1),
                            child: Container(
                                // height: 7, // for vertical axis
                                width: 5, // for horizontal axis
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffA7005E),
                                )),
                          );
                        });
                  },
                ),
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay.value,
                headerVisible: false,
                selectedDayPredicate: (day) => _selectedDays.contains(day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: (eventLoader) =>
                    _getEventsForDay(_kEvents, eventLoader),
                onDaySelected: (selectedDate, focusedDate) =>
                    _onDaySelected(_kEvents, selectedDate, focusedDate),
                onRangeSelected: (start, end, focused) =>
                    _onRangeSelected(_kEvents, start, end, focused),
                onCalendarCreated: (controller) => _pageController = controller,
                onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() => _calendarFormat = format);
                  }
                },
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            onTap: () => print('${value[index]}'),
                            title: Text('${value[index]}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
