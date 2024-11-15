import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niharbuliya_habbit_tracker/state/habit_model.dart';
import 'package:niharbuliya_habbit_tracker/widget/habit_card.dart';
import 'package:niharbuliya_habbit_tracker/widget/motivational_qoute.dart';

import '../state/habit_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the habitProvider to get the current list of habits
    final habits = ref.watch(habitProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Get FIT With NIHAR BULIYA"), actions: [
        IconButton(
          onPressed: () {
            context.push('/overview');
          },
          icon: const Icon(Icons.favorite),
        ),
        IconButton(
          onPressed: () {
            context.push('/settings');
          },
          icon: const Icon(Icons.settings),
        ),
      ]),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with daily overview
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: const MotivationalQuote(),
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Display the number of habits completed today
                  Text(
                    "Total Habits Completed: ${habits.where((h) => h.progress >= h.frequency).length}",
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          // Habit Overview List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return HabitCard(habit: habits[index]);
              },
              childCount: habits.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddHabitDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Function to show the add habit dialog
  void _showAddHabitDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController frequencyController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Habit Name'),
              ),
              TextField(
                controller: frequencyController,
                decoration:
                    const InputDecoration(labelText: 'Target Frequency'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final habitName = nameController.text;
                final frequency = int.tryParse(frequencyController.text) ?? 1;

                if (habitName.isNotEmpty) {
                  ref.read(habitProvider.notifier).addHabit(
                        Habit(
                          id: DateTime.now()
                              .toString(), // Unique ID for each habit
                          name: habitName,
                          frequency: frequency,
                          progress: 0,
                          category: 'Uncategorized',
                        ),
                      );
                  Navigator.pop(context);

                  // Show a toast when a habit is added
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Habit added successfully!')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
