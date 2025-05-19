import 'package:flutter/material.dart';
import 'package:traak/app.dart';
import 'package:traak/shared/repositories/routine_repository.dart';
import 'package:traak/shared/repositories/workout_repository.dart';
import 'package:traak/shared/services/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IsarService.initializeDatabase();

  RoutineRepository.initialize();
  WorkoutRepository.initialize();

  runApp(const TraakApp());
}
