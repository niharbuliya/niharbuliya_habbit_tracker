import 'package:hive/hive.dart';
import '../state/habit_model.dart';

class HiveService {
  static Future<void> saveHabit(Habit habit) async {
    final box = await Hive.openBox<Habit>('habits');
    box.add(habit);
  }

  static Future<List<Habit>> fetchHabits() async {
    final box = await Hive.openBox<Habit>('habits');
    return box.values.toList();
  }
}
