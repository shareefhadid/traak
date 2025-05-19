import 'package:flutter/material.dart';
import 'package:traak/shared/constants/spacing.dart';
import 'package:traak/features/track/components/labeled_value_row.dart';
import 'package:traak/shared/models/exercise.dart';
import 'package:traak/features/track/types/distance.dart';
import 'package:traak/features/track/types/starting_position.dart';

class ExerciseInfoCard extends StatelessWidget {
  const ExerciseInfoCard({
    super.key,
    required this.exercise,
    required this.currentRepNumber,
  });

  final Exercise exercise;
  final int currentRepNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: Spacing.md),
            LabeledValueRow(
              label: 'Distance',
              value: exercise.distance.displayName,
            ),
            LabeledValueRow(
              label: 'Starting Position',
              value: exercise.startingPosition.displayName,
            ),
            LabeledValueRow(
              label: 'Effort',
              value: '${exercise.effort.toStringAsFixed(0)}%',
            ),
            LabeledValueRow(
              label: 'Rep',
              value: '$currentRepNumber of ${exercise.repCount}',
            ),
          ],
        ),
      ),
    );
  }
}
