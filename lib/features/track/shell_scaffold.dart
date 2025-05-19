import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traak/constants/spacing.dart';

class ShellScaffold extends StatelessWidget {
  const ShellScaffold({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  final Widget child;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorScheme.of(context).surfaceContainerLow,
        iconSize: 20.0,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        selectedItemColor: ColorScheme.of(context).primary,
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/history');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: Spacing.md),
              child: Icon(Icons.fitness_center),
            ),
            label: 'Track',
            tooltip: 'Track your training',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: Spacing.md),
              child: Icon(Icons.history),
            ),
            label: 'History',
            tooltip: 'View past workouts',
          ),
        ],
      ),
    );
  }
}
