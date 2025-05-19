import 'package:flutter/material.dart';
import 'package:traak/shared/constants/spacing.dart';

class LabeledValueRow extends StatelessWidget {
  const LabeledValueRow({
    super.key,
    required this.label,
    required this.value,
    this.padding = const EdgeInsets.only(bottom: Spacing.sm),
  });

  final String label;
  final String value;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: TextTheme.of(context).titleMedium),
          Text(value, style: TextTheme.of(context).bodyLarge),
        ],
      ),
    );
  }
}
