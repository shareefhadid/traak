import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traak/shared/constants/spacing.dart';
import 'package:traak/shared/models/workout.dart';
import 'package:traak/features/history/components/workout_info_item.dart';

class WorkoutCard extends StatelessWidget {

  const WorkoutCard({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    final formattedDate = dateFormat.format(workout.createdAt);

    final totalExercises =
        workout.reps.map((r) => r.exerciseName).toSet().length;

    final totalTime = workout.reps.fold<double>(
      0,
      (sum, rep) => sum + rep.completionTime,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: Spacing.md),
      shape: const Border(),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    workout.routineName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextTheme.of(context).titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
            const SizedBox(height: Spacing.xs),
            Text(
              formattedDate,
              style: TextTheme.of(context).bodyMedium!.copyWith(
                color: ColorScheme.of(context).onSurfaceVariant,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WorkoutInfoItem(
                  icon: Icons.fitness_center,
                  text:
                      '$totalExercises exercise${totalExercises == 1 ? '' : 's'}',
                ),
                WorkoutInfoItem(
                  icon: Icons.timer,
                  text: '${totalTime.toStringAsFixed(1)} seconds',
                ),
                WorkoutInfoItem(
                  icon: Icons.repeat,
                  text:
                      '${workout.reps.length} rep${workout.reps.length == 1 ? '' : 's'}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
