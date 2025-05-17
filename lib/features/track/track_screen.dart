import 'package:flutter/material.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/shared/components/app_body_padding.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBodyPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Get started', style: TextTheme.of(context).titleLarge),
            const SizedBox(height: Spacing.sm),
            Text(
              'Create a routine to start tracking your training.',
              style: TextTheme.of(context).bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.md),
            ElevatedButton(onPressed: () {}, child: const Text('Add routine')),
          ],
        ),
      ),
    );
  }
}
