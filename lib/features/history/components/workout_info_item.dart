import 'package:flutter/material.dart';
import 'package:traak/shared/constants/spacing.dart';

class WorkoutInfoItem extends StatelessWidget {

  const WorkoutInfoItem({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: ColorScheme.of(context).outline),
        const SizedBox(width: Spacing.xs),
        Text(
          text,
          style: TextTheme.of(
            context,
          ).bodySmall!.copyWith(color: ColorScheme.of(context).outline),
        ),
      ],
    );
  }
}
