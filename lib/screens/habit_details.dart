import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/habit_provider.dart';
import '../state/habit_model.dart';

class HabitDetailsScreen extends ConsumerWidget {
  final Habit habit;

  const HabitDetailsScreen({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: habit.name);
    final frequencyController =
        TextEditingController(text: habit.frequency.toString());
    final progressController =
        TextEditingController(text: habit.progress.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteDialog(context, ref);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Habit Name'),
            ),
            TextField(
              controller: frequencyController,
              decoration: const InputDecoration(labelText: 'Target Frequency'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: progressController,
              decoration: const InputDecoration(labelText: 'Enter Progress'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateHabit(
                    ref,
                    nameController.text,
                    int.parse(frequencyController.text),
                    int.parse(progressController.text));
              },
              child: const Text('Update Habit'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle updating the habit
  void _updateHabit(
      WidgetRef ref, String newName, int newFrequency, int progress) {
    final updatedHabit = habit.copyWith(
        name: newName, frequency: newFrequency, progress: progress);
    ref.read(habitProvider.notifier).updateHabit(updatedHabit);

    // Show success message
    ScaffoldMessenger.of(ref.context).showSnackBar(
      const SnackBar(content: Text('Habit updated successfully!')),
    );
    Navigator.pop(ref.context);
  }

  // Method to handle showing the delete confirmation dialog
  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Habit'),
          content: const Text('Are you sure you want to delete this habit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteHabit(ref);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Method to handle deleting the habit
  void _deleteHabit(WidgetRef ref) {
    ref.read(habitProvider.notifier).deleteHabit(habit);

    // Show success message
    ScaffoldMessenger.of(ref.context).showSnackBar(
      const SnackBar(content: Text('Habit deleted successfully!')),
    );
    Navigator.pop(ref.context); // Navigate back to previous screen
  }
}
