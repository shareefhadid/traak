import 'package:flutter/material.dart';
import 'package:traak/features/track/models/rep.dart';

class Exercise {
  Exercise({required this.id});
  final int id;
  String name = '';
  final TextEditingController distanceController = TextEditingController(
    text: '60',
  );
  double effort = 100;
  String startingPosition = 'Standing';
  List<Rep> reps = [Rep(id: 0)];
}
