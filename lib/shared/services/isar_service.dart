import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:traak/features/track/models/routine.dart';
import 'package:traak/features/track/types/distance.dart';

class IsarService {
  // Private constructor that takes an initialized Isar instance
  IsarService._(this._db);

  // The actual database instance
  final Isar _db;

  // Private static instance variable
  static IsarService? _instance;

  // Public getter that returns the instance if it exists
  static IsarService get instance {
    if (_instance == null) {
      throw Exception(
        'IsarService has not been initialized. Call initializeDatabase() first.',
      );
    }
    return _instance!;
  }

  // Static initialization method to be called at app startup
  static Future<void> initializeDatabase() async {
    if (_instance != null) return;

    try {
      final dir = await getApplicationDocumentsDirectory();

      final Isar isar;
      if (Isar.instanceNames.isNotEmpty) {
        isar =
            Isar.getInstance()!; // Non-null assertion since we checked if it exists
      } else {
        isar = await Isar.open([RoutineSchema], directory: dir.path);
      }

      _instance = IsarService._(isar);
    } catch (e) {
      throw Exception('Failed to open Isar database: $e');
    }
  }

  // Routines CRUD operations
  Future<List<Routine>> getAllRoutines() async {
    return await _db.routines.where().sortByCreatedAtDesc().findAll();
  }

  Future<Routine?> getRoutineById(int id) async {
    return await _db.routines.get(id);
  }

  Future<int> saveRoutine(Routine routine) async {
    if (routine.name.isEmpty) {
      throw Exception('Routine name cannot be empty');
    }

    if (routine.exercises.isEmpty) {
      throw Exception('Routine must have at least one exercise');
    }

    for (final exercise in routine.exercises) {
      if (exercise.name.isEmpty) {
        throw Exception('Exercise name cannot be empty');
      }
      if (exercise.distance.meters <= 0) {
        throw Exception('Exercise distance must be greater than 0');
      }
      if (exercise.repCount <= 0) {
        throw Exception('Exercise rep count must be greater than 0');
      }
    }

    int id = 0;
    await _db.writeTxn(() async {
      id = await _db.routines.put(routine);
    });
    return id;
  }

  Future<bool> deleteRoutine(int id) async {
    return await _db.writeTxn(() async {
      return await _db.routines.delete(id);
    });
  }

  // Get a stream of routines for reactive UI updates
  Stream<List<Routine>> watchAllRoutines() {
    return _db.routines.where().sortByCreatedAtDesc().watch(
      fireImmediately: true,
    );
  }
}
