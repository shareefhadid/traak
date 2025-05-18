import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

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
  String startingPosition = 'Standing';
  int repCount = 1;
}
