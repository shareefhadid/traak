import 'package:flutter/material.dart';
import 'package:traak/shared/components/labeled_value_row.dart';
import 'package:traak/shared/constants/spacing.dart';
import 'package:traak/shared/models/workout.dart';
import 'package:traak/features/track/types/distance.dart';
import 'package:traak/features/track/types/starting_position.dart';

class ExerciseRepCard extends StatelessWidget {
  const ExerciseRepCard({super.key, required this.rep});

  final WorkoutRep rep;

  @override
  Widget build(BuildContext context) {
    // Convert raw values to proper types
    final distance = SprintDistanceExtension.fromMeters(rep.distanceInMeters);
    final startingPosition = StartingPositionExtension.fromString(
      rep.startingPosition,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${rep.exerciseName} (rep ${rep.repNumber})',
                style: TextTheme.of(context).titleMedium,
              ),
              const SizedBox(height: Spacing.md),
              LabeledValueRow(label: 'Distance', value: distance.displayName),
              LabeledValueRow(
                label: 'Starting Position',
                value: startingPosition.displayName,
              ),
              LabeledValueRow(
                label: 'Effort',
                value: '${rep.effort.toStringAsFixed(0)}%',
              ),
              LabeledValueRow(
                label: 'Time',
                value: '${rep.completionTime.toStringAsFixed(1)} sec',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
