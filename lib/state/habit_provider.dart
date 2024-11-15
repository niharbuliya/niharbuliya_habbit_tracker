import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'habit_model.dart';

class HabitNotifier extends StateNotifier<List<Habit>> {
  HabitNotifier() : super([]);

  // Add a habit to the list
  void addHabit(Habit habit) {
    state = [...state, habit];
  }

  // Update an existing habit
  void updateHabit(Habit updatedHabit) {
    state = [
      for (final habit in state)
        if (habit.id == updatedHabit.id) updatedHabit else habit
    ];
  }

  // Delete a habit
  void deleteHabit(Habit habitToDelete) {
    state = state.where((habit) => habit.id != habitToDelete.id).toList();
  }
}

// This is the provider that will manage the state of habits
final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>((ref) {
  return HabitNotifier();
});
