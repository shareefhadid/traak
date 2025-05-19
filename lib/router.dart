import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traak/features/history/workout_details_screen.dart';
import 'package:traak/features/history/workout_history_screen.dart';
import 'package:traak/features/track/edit_routine_screen.dart';
import 'package:traak/features/track/new_routine_screen.dart';
import 'package:traak/features/track/track_screen.dart';
import 'package:traak/features/track/workout_screen.dart';
import 'package:traak/shared/components/shell_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        int currentIndex = 0;
        if (state.matchedLocation.startsWith('/history')) {
          currentIndex = 1;
        }

        return ShellScaffold(currentIndex: currentIndex, child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'track',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: TrackScreen());
          },
          routes: [
            GoRoute(
              path: 'new-routine',
              name: 'new-routine',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const NewRoutineScreen(),
            ),
            GoRoute(
              path: 'edit-routine/:id',
              name: 'edit-routine',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                final routineId = int.parse(state.pathParameters['id']!);
                return EditRoutineScreen(routineId: routineId);
              },
            ),
            GoRoute(
              path: 'workout/:id',
              name: 'workout',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                final routineId = int.parse(state.pathParameters['id']!);
                return WorkoutScreen(routineId: routineId);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/history',
          name: 'history',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: WorkoutHistoryScreen());
          },
          routes: [
            GoRoute(
              path: 'workout/:id',
              name: 'workout-details',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                final workoutId = int.parse(state.pathParameters['id']!);
                return WorkoutDetailsScreen(workoutId: workoutId);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
