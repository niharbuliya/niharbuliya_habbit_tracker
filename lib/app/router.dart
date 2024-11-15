import 'package:go_router/go_router.dart';
import 'package:niharbuliya_habbit_tracker/screens/dashboard_screen.dart';
import 'package:niharbuliya_habbit_tracker/screens/habit_details.dart';
import 'package:niharbuliya_habbit_tracker/screens/habit_overview.dart';
import 'package:niharbuliya_habbit_tracker/screens/settings.dart';
import '../state/habit_model.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/overview',
      name: 'habitOverview',
      builder: (context, state) => const HabitOverviewScreen(),
    ),
    GoRoute(
      path: '/details',
      name: 'habitDetails',
      builder: (context, state) {
        // Ensure Habit is passed as an argument
        final habit = state.extra as Habit?;
        if (habit == null) {
          throw Exception(
              "Habit data is required to navigate to HabitDetailsScreen.");
        }
        return HabitDetailsScreen(habit: habit);
      },
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
