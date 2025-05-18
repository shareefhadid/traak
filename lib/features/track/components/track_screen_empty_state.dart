import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/shared/components/app_body_padding.dart';

class TrackScreenEmptyState extends StatelessWidget {
  const TrackScreenEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBodyPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Get started', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: Spacing.sm),
            Text(
              'Create a routine to start tracking your training.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.md),
            ElevatedButton(
              onPressed: () => context.go('/new-routine'),
              child: const Text('Add routine'),
            ),
          ],
        ),
      ),
    );
  }
}
