import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:traak/features/history/components/workout_info_item.dart';
import 'package:traak/shared/components/confirmation_dialog.dart';
import 'package:traak/shared/constants/spacing.dart';
import 'package:traak/shared/models/workout.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.workout, required this.onDelete});

  final Workout workout;
  final Future<void> Function(Workout workout) onDelete;

  Future<void> _handleDelete(BuildContext context) async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: 'Delete Workout',
      message: 'Are you sure you want to delete this workout?',
      confirmText: 'Delete',
      cancelText: 'Cancel',
    );

    if (confirmed == true) {
      await onDelete(workout);
    }
  }

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

    return InkWell(
      onTap:
          () => context.goNamed(
            'workout-details',
            pathParameters: {'id': workout.id.toString()},
          ),
      child: Card(
        margin: const EdgeInsets.only(bottom: Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(workout.routineName),
              subtitle: Text(formattedDate),
              trailing: PopupMenuButton<String>(
                useRootNavigator: true,
                icon: const Icon(Icons.more_horiz),
                onSelected: (value) {
                  if (value == 'delete') {
                    _handleDelete(context);
                  }
                },
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, size: 20),
                            SizedBox(width: Spacing.sm),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: Spacing.md,
                left: Spacing.body,
                right: Spacing.body,
                bottom: Spacing.body,
              ),
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
