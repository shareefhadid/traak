import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:traak/features/track/types/starting_position.dart';

part 'exercise.g.dart';

@embedded
class Exercise {
  Exercise() {
    // Generate a unique ID using UUID
    uuid = const Uuid().v4();
  }

  // Persistent UUID for the exercise
  String uuid = '';

  // Core exercise data
  String name = '';
  int distance = 60;
  double effort = 100;

  @Enumerated(EnumType.name)
  StartingPosition startingPosition = StartingPosition.block;

  int repCount = 1;
}
