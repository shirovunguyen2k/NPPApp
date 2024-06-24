import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app_states/nav_states/nav_states.dart';

// class NavNotifier extends StateNotifier<NavNotifier> {
//   NavNotifier() : super(const NavStates());
// }

class NavNotifier extends StateNotifier<NavStates> {
  NavNotifier() : super(const NavStates());

  // Add any methods to manipulate the state here
  void updateIndex(int newIndex) {
    state = state.copyWith(index: newIndex);
  }
}

final navProvider =
    StateNotifierProvider<NavNotifier, NavStates>((ref) => NavNotifier());
