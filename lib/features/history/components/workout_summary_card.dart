import 'package:flutter/material.dart';
import 'package:traak/shared/components/labeled_value_row.dart';
import 'package:traak/shared/constants/spacing.dart';

class WorkoutSummaryCard extends StatelessWidget {
  const WorkoutSummaryCard({
    super.key,
    required this.date,
    required this.exerciseCount,
    required this.repCount,
    required this.totalTime,
  });

  final String date;
  final int exerciseCount;
  final int repCount;
  final String totalTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Workout Summary', style: TextTheme.of(context).titleLarge),
            const SizedBox(height: Spacing.xl),
            LabeledValueRow(label: 'Date', value: date),
            LabeledValueRow(
              label: 'Exercises',
              value: exerciseCount.toString(),
            ),
            LabeledValueRow(label: 'Total Reps', value: repCount.toString()),
            LabeledValueRow(label: 'Total Time', value: totalTime),
          ],
        ),
      ),
    );
  }
}
