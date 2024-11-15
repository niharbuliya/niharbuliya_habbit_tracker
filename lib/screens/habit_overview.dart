import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niharbuliya_habbit_tracker/widget/habit_card.dart';
import '../state/habit_provider.dart';

class HabitOverviewScreen extends ConsumerWidget {
  const HabitOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Overview'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
        ),
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return HabitCard(habit: habits[index]);
        },
      ),
    );
  }
}
