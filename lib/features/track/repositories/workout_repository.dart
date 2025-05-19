import 'package:traak/features/track/models/exercise.dart';
import 'package:traak/features/track/models/routine.dart';
import 'package:traak/features/track/models/workout.dart';
import 'package:traak/shared/services/isar_service.dart';

class WorkoutRepository {
  WorkoutRepository._({IsarService? isarService})
    : _isarService = isarService ?? IsarService.instance;
  final IsarService _isarService;

  // Singleton pattern
  static WorkoutRepository? _instance;

  static WorkoutRepository get instance {
    if (_instance == null) {
      throw Exception(
        'WorkoutRepository has not been initialized. Call initialize() first.',
      );
    }
    return _instance!;
  }

  // Initialization method
  static void initialize() {
    if (_instance != null) return;
    _instance = WorkoutRepository._();
  }

  // Read operations
  Future<List<Workout>> getAllWorkouts() {
    return _isarService.getAllWorkouts();
  }

  Future<List<Workout>> getWorkoutsByRoutineId(int routineId) {
    return _isarService.getWorkoutsByRoutineId(routineId);
  }

  Future<Workout?> getWorkoutById(int id) {
    return _isarService.getWorkoutById(id);
  }

  Stream<List<Workout>> watchAllWorkouts() {
    return _isarService.watchAllWorkouts();
  }

  Stream<List<Workout>> watchWorkoutsByRoutineId(int routineId) {
    return _isarService.watchWorkoutsByRoutineId(routineId);
  }

  // Write operations
  Future<int> saveWorkout(Workout workout) async {
    return _isarService.saveWorkout(workout);
  }

  Future<bool> deleteWorkout(int id) async {
    return _isarService.deleteWorkout(id);
  }

  // Business logic methods

  /// Creates a new workout instance from a routine
  Workout createWorkoutFromRoutine(Routine routine) {
    return Workout()
      ..routineId = routine.id
      ..routineName = routine.name
      ..routineType = routine.type;
  }

  /// Validates and creates a workout rep
  /// Returns a result object indicating success/failure with error message
  RecordRepResult recordRep({
    required Workout workout,
    required Exercise exercise,
    required int repNumber,
    required String timeInput,
  }) {
    // Validate time input
    if (timeInput.trim().isEmpty) {
      return RecordRepResult.failure('Please enter a completion time');
    }

    double completionTime;
    try {
      completionTime = double.parse(timeInput);
      if (completionTime <= 0) {
        throw const FormatException('Time must be positive');
      }
    } catch (e) {
      return RecordRepResult.failure('Please enter a valid time in seconds');
    }

    // Create the rep
    final rep =
        WorkoutRep()
          ..exerciseName = exercise.name
          ..distanceInMeters = exercise.distanceInMeters
          ..effort = exercise.effort
          ..startingPosition = exercise.startingPosition.toString()
          ..exerciseUuid = exercise.uuid
          ..repNumber = repNumber
          ..completionTime = completionTime;

    // Add it to the workout
    workout.reps.add(rep);

    return RecordRepResult.success();
  }

  /// Validates and completes a workout
  Future<bool> completeWorkout(Workout workout) async {
    if (workout.reps.isEmpty) {
      return false;
    }

    await saveWorkout(workout);
    return true;
  }
}

/// Represents the result of a record rep operation
class RecordRepResult {
  RecordRepResult.success() : success = true, errorMessage = null;
  RecordRepResult.failure(this.errorMessage) : success = false;

  final bool success;
  final String? errorMessage;
}
