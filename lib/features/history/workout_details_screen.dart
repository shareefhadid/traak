import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traak/features/history/components/exercise_rep_card.dart';
import 'package:traak/features/history/components/workout_summary_card.dart';
import 'package:traak/shared/components/custom_app_bar.dart';
import 'package:traak/shared/constants/spacing.dart';
import 'package:traak/shared/models/workout.dart';
import 'package:traak/shared/repositories/workout_repository.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  const WorkoutDetailsScreen({super.key, required this.workoutId});

  final int workoutId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Workout?>(
      future: WorkoutRepository.instance.getWorkoutById(workoutId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            appBar: CustomAppBar(title: 'Workout Details'),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: const CustomAppBar(title: 'Error', showBack: true),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final workout = snapshot.data;
        if (workout == null) {
          return const Scaffold(
            appBar: CustomAppBar(title: 'Not Found', showBack: true),
            body: Center(child: Text('Workout not found')),
          );
        }

        return WorkoutDetailsView(workout: workout);
      },
    );
  }
}

class WorkoutDetailsView extends StatelessWidget {
  const WorkoutDetailsView({super.key, required this.workout});

  final Workout workout;

  String _formatTime(double seconds) {
    if (seconds >= 60) {
      final minutes = (seconds / 60).floor();
      final remainingSeconds = (seconds % 60).toStringAsFixed(1);
      return '$minutes min $remainingSeconds sec';
    }
    return '${seconds.toStringAsFixed(1)} sec';
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM d, yyyy • h:mm a');
    final formattedDate = dateFormat.format(workout.createdAt);

    final exerciseCount =
        workout.reps.map((rep) => rep.exerciseName).toSet().length;

    final totalTime = workout.reps.fold<double>(
      0,
      (sum, rep) => sum + rep.completionTime,
    );

    return Scaffold(
      appBar: CustomAppBar(title: workout.routineName, showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: Spacing.body,
          right: Spacing.body,
          top: Spacing.body,
          bottom: Spacing.xl5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WorkoutSummaryCard(
              date: formattedDate,
              exerciseCount: exerciseCount,
              repCount: workout.reps.length,
              totalTime: _formatTime(totalTime),
            ),
            const SizedBox(height: Spacing.md),
            ...workout.reps.map((rep) => ExerciseRepCard(rep: rep)),
          ],
        ),
      ),
    );
  }
}
