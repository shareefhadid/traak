import 'package:flutter/material.dart';
import 'package:traak/features/history/components/workout_details_view.dart';
import 'package:traak/shared/components/custom_app_bar.dart';
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
