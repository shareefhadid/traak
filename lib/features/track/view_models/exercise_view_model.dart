import 'package:flutter/material.dart';
import 'package:traak/features/track/models/exercise.dart';

/// ViewModel for Exercise that handles UI-related logic
class ExerciseViewModel {
  ExerciseViewModel({required this.exercise}) {
    // Initialize controllers with current model values
    distanceController = TextEditingController(
      text: exercise.distance.toString(),
    );
    repCountController = TextEditingController(
      text: exercise.repCount.toString(),
    );
  }

  /// The underlying exercise model
  final Exercise exercise;

  /// Controller for the distance field
  late final TextEditingController distanceController;

  /// Controller for the rep count field
  late final TextEditingController repCountController;

  /// Updates the exercise model with current controller values
  void save() {
    // Parse distance
    final distanceValue = int.tryParse(distanceController.text);
    if (distanceValue == null) {
      throw Exception('Exercise distance must be a valid number');
    }
    if (distanceValue <= 0) {
      throw Exception('Exercise distance must be greater than 0');
    }
    exercise.distance = distanceValue;

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

  /// Clean up resources
  void dispose() {
    distanceController.dispose();
    repCountController.dispose();
  }
}
