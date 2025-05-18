import 'package:go_router/go_router.dart';
import 'package:traak/features/track/track_screen.dart';
import 'package:traak/features/track/new_routine_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TrackScreen(),
      routes: [
        GoRoute(
          path: 'new-routine',
          builder: (context, state) => const NewRoutineScreen(),
        ),
      ],
    ),
  ],
);
