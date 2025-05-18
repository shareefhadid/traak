import 'package:traak/features/track/models/routine.dart';
import 'package:traak/services/isar_service.dart';

class RoutineRepository {
  RoutineRepository._({IsarService? isarService})
    : _isarService = isarService ?? IsarService.instance;
  final IsarService _isarService;

  // Singleton pattern
  static RoutineRepository? _instance;

  static RoutineRepository get instance {
    if (_instance == null) {
      throw Exception(
        'RoutineRepository has not been initialized. Call initialize() first.',
      );
    }
    return _instance!;
  }

  // Initialization method
  static void initialize() {
    if (_instance != null) return;
    _instance = RoutineRepository._();
  }

  // Read operations
  Future<List<Routine>> getAllRoutines() {
    return _isarService.getAllRoutines();
  }

  Future<Routine?> getRoutineById(int id) {
    return _isarService.getRoutineById(id);
  }

  Stream<List<Routine>> watchAllRoutines() {
    return _isarService.watchAllRoutines();
  }

  // Write operations
  Future<int> saveRoutine(Routine routine) async {
    return _isarService.saveRoutine(routine);
  }

  Future<bool> deleteRoutine(int id) async {
    return _isarService.deleteRoutine(id);
  }
}
