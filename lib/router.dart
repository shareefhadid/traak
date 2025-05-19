import 'package:go_router/go_router.dart';
import 'package:traak/features/track/track_screen.dart';
import 'package:traak/features/track/new_routine_screen.dart';
import 'package:traak/features/track/edit_routine_screen.dart';
import 'package:traak/features/track/workout_screen.dart';
import 'package:traak/features/track/workout_history_screen.dart';
import 'package:traak/features/track/shell_scaffold.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
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
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: TrackScreen());
          },
          routes: [
            GoRoute(
              path: 'new-routine',
              builder: (context, state) => const NewRoutineScreen(),
            ),
            GoRoute(
              path: 'edit-routine/:id',
              builder: (context, state) {
                final routineId = int.parse(state.pathParameters['id']!);
                return EditRoutineScreen(routineId: routineId);
              },
            ),
            GoRoute(
              path: 'workout/:id',
              builder: (context, state) {
                final routineId = int.parse(state.pathParameters['id']!);
                return WorkoutScreen(routineId: routineId);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/history',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: WorkoutHistoryScreen());
          },
        ),
      ],
    ),
  ],
);
