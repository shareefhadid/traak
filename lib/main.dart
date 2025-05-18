import 'package:flutter/material.dart';
import 'package:traak/app.dart';
import 'package:traak/features/track/repositories/routine_repository.dart';
import 'package:traak/services/isar_service.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  await IsarService.initializeDatabase();

  // Initialize repository
  RoutineRepository.initialize();

  // Run the app
  runApp(const TraakApp());
}
