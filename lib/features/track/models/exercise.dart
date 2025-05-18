import 'package:flutter/material.dart';

class Exercise {
  Exercise({required this.id});
  final int id;
  String name = '';
  final TextEditingController distanceController = TextEditingController(
    text: '60',
  );
  double effort = 100;
  String startingPosition = 'Standing';
  int repCount = 1;
}
