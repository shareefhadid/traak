import 'package:flutter/material.dart';
import 'package:traak/shared/components/custom_app_bar.dart';
import 'package:traak/shared/constants/spacing.dart';
import 'package:traak/shared/models/workout.dart';
import 'package:traak/shared/repositories/workout_repository.dart';
import 'package:traak/features/history/components/workout_card.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<WorkoutHistoryScreen> createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  final _workoutRepo = WorkoutRepository.instance;

  Future<void> _handleDeleteWorkout(Workout workout) async {
    try {
      await _workoutRepo.deleteWorkout(workout.id);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete workout: $e')));
      }
    }
  }

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

          return ListView.builder(
            itemCount: workouts.length,
            padding: const EdgeInsets.only(
              top: Spacing.lg,
              left: Spacing.body,
              right: Spacing.body,
              bottom: Spacing.body,
            ),
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return WorkoutCard(
                workout: workout,
                onDelete: _handleDeleteWorkout,
              );
            },
          );
        },
      ),
    );
  }
}
