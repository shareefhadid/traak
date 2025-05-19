import 'package:flutter/material.dart';
import 'package:traak/shared/models/exercise.dart';
import 'package:traak/features/track/types/distance.dart';

/// ViewModel for Exercise that handles UI-related logic
class ExerciseViewModel {
  ExerciseViewModel({required this.exercise}) {
    // Initialize controllers with current model values
    nameController = TextEditingController(text: exercise.name);
    distanceController = TextEditingController(
      text: exercise.distance.meters.toString(),
    );
    repCountController = TextEditingController(
      text: exercise.repCount.toString(),
    );
  }

  /// The underlying exercise model
  final Exercise exercise;

  /// Controller for the name field
  late final TextEditingController nameController;

  /// Controller for the distance field
  late final TextEditingController distanceController;

  /// Controller for the rep count field
  late final TextEditingController repCountController;

  /// List of available distances for dropdown
  List<SprintDistance> get availableDistances => SprintDistance.values;

  /// Updates the exercise model with current controller values
  void save() {
    // Update exercise name
    exercise.name = nameController.text;

    // Parse distance
    final distanceValue = int.tryParse(distanceController.text);
    if (distanceValue == null) {
      throw Exception('Exercise distance must be a valid number');
    }
    if (distanceValue <= 0) {
      throw Exception('Exercise distance must be greater than 0');
    }

    // Find the closest standard distance
    exercise.distance = SprintDistanceExtension.fromMeters(distanceValue);

    // Parse rep count
    final repValue = int.tryParse(repCountController.text);
    if (repValue == null) {
      throw Exception('Exercise rep count must be a valid number');
    }
    if (repValue <= 0) {
      throw Exception('Exercise rep count must be greater than 0');
    }
    exercise.repCount = repValue;
  }

  /// Updates the rep count and the controller
  void updateRepCount(int count) {
    if (count > 0) {
      exercise.repCount = count;
      repCountController.text = count.toString();
    }
  }

  /// Updates the distance and the controller
  void updateDistance(SprintDistance distance) {
    exercise.distance = distance;
    distanceController.text = distance.meters.toString();
  }

  /// Clean up resources
  void dispose() {
    nameController.dispose();
    distanceController.dispose();
    repCountController.dispose();
  }
}
