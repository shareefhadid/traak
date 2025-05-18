import 'package:isar/isar.dart';
import 'package:traak/features/track/models/exercise.dart';
import 'package:traak/features/track/types/routine_type.dart';

part 'routine.g.dart';

@collection
class Routine {
  Routine();
  Id id = Isar.autoIncrement;

  String name = '';

  @Enumerated(EnumType.name)
  RoutineType type = RoutineType.acceleration;

  List<Exercise> exercises = [];

  DateTime createdAt = DateTime.now();

  // Helper methods for UI
  int get exerciseCount => exercises.length;

  @Index()
  String get nameIndex => name.toLowerCase();

  @Index()
  String get typeIndex => type.toString().toLowerCase();
}
