import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traak/shared/models/workout.dart';
import 'package:traak/shared/repositories/workout_repository.dart';
import 'package:traak/shared/components/custom_app_bar.dart';
import 'package:traak/shared/components/app_body_padding.dart';
import 'package:traak/shared/constants/spacing.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<WorkoutHistoryScreen> createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  final _workoutRepo = WorkoutRepository.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Workout History'),
      body: StreamBuilder<List<Workout>>(
        stream: _workoutRepo.watchAllWorkouts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final workouts = snapshot.data ?? [];

          if (workouts.isEmpty) {
            return const Center(child: Text('No workout history yet'));
          }

          return AppBodyPadding(
            child: ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                final workout = workouts[index];
                return _buildWorkoutCard(workout);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildWorkoutCard(Workout workout) {
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    final formattedDate = dateFormat.format(workout.createdAt);

    // Calculate total exercises and total time
    final totalExercises =
        workout.reps.map((r) => r.exerciseName).toSet().length;
    final totalTime = workout.reps.fold<double>(
      0,
      (sum, rep) => sum + rep.completionTime,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: Spacing.md),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.routineName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: Spacing.xs),
            Text(
              formattedDate,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem(
                  Icons.fitness_center,
                  '$totalExercises exercise${totalExercises == 1 ? '' : 's'}',
                ),
                _buildInfoItem(
                  Icons.timer,
                  '${totalTime.toStringAsFixed(1)} seconds',
                ),
                _buildInfoItem(
                  Icons.repeat,
                  '${workout.reps.length} rep${workout.reps.length == 1 ? '' : 's'}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
