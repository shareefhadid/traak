import 'package:flutter/material.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/features/track/track_screen.dart';
import 'package:traak/theme.dart';

class TraakApp extends StatelessWidget {
  const TraakApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traak',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const TrackScreen(),
    );
  }
}
