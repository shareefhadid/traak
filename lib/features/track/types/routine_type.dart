enum RoutineType {
  acceleration,
  maxVelocity,
  speedEndurance,
  specialEndurance,
  technicalDrills,
  tempo,
}

extension RoutineTypeExtension on RoutineType {
  // Display names for UI
  String get displayName {
    switch (this) {
      case RoutineType.acceleration:
        return 'Acceleration';
      case RoutineType.maxVelocity:
        return 'Max Velocity';
      case RoutineType.speedEndurance:
        return 'Speed Endurance';
      case RoutineType.specialEndurance:
        return 'Special Endurance';
      case RoutineType.technicalDrills:
        return 'Technical drills';
      case RoutineType.tempo:
        return 'Tempo';
    }
  }

  // Parse from string (for database storage)
  static RoutineType fromString(String value) {
    return RoutineType.values.firstWhere(
      (type) => type.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => RoutineType.acceleration,
    );
  }
}
