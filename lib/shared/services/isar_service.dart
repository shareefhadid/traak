import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:traak/shared/models/routine.dart';
import 'package:traak/shared/models/workout.dart';
import 'package:traak/features/track/types/distance.dart';

class IsarService {
  IsarService._(this._db);

  final Isar _db;

  static IsarService? _instance;

  static IsarService get instance {
    if (_instance == null) {
      throw Exception(
        'IsarService has not been initialized. Call initializeDatabase() first.',
      );
    }
    return _instance!;
  }

  static Future<void> initializeDatabase() async {
    if (_instance != null) return;

    try {
      final dir = await getApplicationDocumentsDirectory();

      final Isar isar;
      if (Isar.instanceNames.isNotEmpty) {
        isar =
            Isar.getInstance()!; // Non-null assertion since we checked if it exists
      } else {
        isar = await Isar.open([
          RoutineSchema,
          WorkoutSchema,
        ], directory: dir.path);
      }

      _instance = IsarService._(isar);
    } catch (e) {
      throw Exception('Failed to open Isar database: $e');
    }
  }

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

  Stream<List<Routine>> watchAllRoutines() {
    return _db.routines.where().sortByCreatedAtDesc().watch(
      fireImmediately: true,
    );
  }

  Future<List<Workout>> getAllWorkouts() async {
    return await _db.workouts.where().sortByCreatedAtDesc().findAll();
  }

  Future<List<Workout>> getWorkoutsByRoutineId(int routineId) async {
    return await _db.workouts
        .where()
        .routineIdIndexEqualTo(routineId)
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<Workout?> getWorkoutById(int id) async {
    return await _db.workouts.get(id);
  }

  Future<int> saveWorkout(Workout workout) async {
    if (workout.routineName.isEmpty) {
      throw Exception('Workout routine name cannot be empty');
    }

    if (workout.routineId <= 0) {
      throw Exception('Workout must reference a valid routine ID');
    }

    if (workout.reps.isEmpty) {
      throw Exception('Workout must have at least one rep');
    }

    int id = 0;
    await _db.writeTxn(() async {
      id = await _db.workouts.put(workout);
    });
    return id;
  }

  Future<bool> deleteWorkout(int id) async {
    return await _db.writeTxn(() async {
      return await _db.workouts.delete(id);
    });
  }

  Stream<List<Workout>> watchAllWorkouts() {
    return _db.workouts.where().sortByCreatedAtDesc().watch(
      fireImmediately: true,
    );
  }

  Stream<List<Workout>> watchWorkoutsByRoutineId(int routineId) {
    return _db.workouts
        .where()
        .routineIdIndexEqualTo(routineId)
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }
}
