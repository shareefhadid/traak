import 'package:isar/isar.dart';
import 'package:traak/features/track/types/routine_type.dart';

part 'workout.g.dart';

@collection
class Workout {
  Workout();
  Id id = Isar.autoIncrement;

  // When the workout was created
  DateTime createdAt = DateTime.now();

  // Snapshot of routine data (for independence)
  String routineName = '';

  @Enumerated(EnumType.name)
  RoutineType routineType = RoutineType.acceleration;

  // Reference to routine
  int routineId = 0;

  // Collection of rep data
  List<WorkoutRep> reps = [];

  @Index()
  DateTime get createdAtIndex => createdAt;

  @Index()
  int get routineIdIndex => routineId;
}

@embedded
class WorkoutRep {
  // Snapshot of exercise data
  String exerciseName = '';

  int distanceInMeters = 60;

  double effort = 100;

  String startingPosition = 'Block';

  // Reference to exercise
  String exerciseUuid = '';

  // Which rep number this was (1-based)
  int repNumber = 1;

  // The actual tracked data - time in seconds
  double completionTime = 0.0;
}
