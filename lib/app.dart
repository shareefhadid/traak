import 'package:flutter/material.dart';

class TraakApp extends StatelessWidget {
  const TraakApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traak',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Placeholder(),
    );
  }
}
