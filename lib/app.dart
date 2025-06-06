import 'package:flutter/material.dart';
import 'package:traak/router.dart';
import 'package:traak/theme.dart';

class TraakApp extends StatelessWidget {
  const TraakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Traak',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      routerConfig: router,
    );
  }
}
