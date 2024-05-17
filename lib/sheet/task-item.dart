import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/sheet/tasks-list.dart';

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd-MM-yy HH:mm");
    final task = widget.task;
    return Card(
      margin: const EdgeInsets.all(10),
      borderOnForeground: true,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: ListTile(
        title: Text(task.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.greenAccent)),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(task.description),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${dateFormat.format(task.formTo.start)} - ${dateFormat.format(task.formTo.end)}",
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(task.priority,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 34, 166, 237))),
              Image.network(
                "https://i.pinimg.com/564x/04/55/f8/0455f8b954449f0e7c1af387ac37959f.jpg",
                height: 40,
                width: 150,
                fit: BoxFit.fitWidth,
              ),
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2439821483.
              TextButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: BorderSide.none,
                ),
                child: const Icon(Icons.more),
              )
            ],
          )
        ]),
        leading: const Icon(Icons.coffee, color: Colors.blueGrey,),
        
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({super.key, required this.task});
  @override
  State<TaskItem> createState() => _TaskItemState();
}
