enum SprintDistance { m30, m40, m60, m100, m150, m200, m300, m400, m500, m600 }

extension SprintDistanceExtension on SprintDistance {
  String get displayName {
    switch (this) {
      case SprintDistance.m30:
        return '30m';
      case SprintDistance.m40:
        return '40m';
      case SprintDistance.m60:
        return '60m';
      case SprintDistance.m100:
        return '100m';
      case SprintDistance.m150:
        return '150m';
      case SprintDistance.m200:
        return '200m';
      case SprintDistance.m300:
        return '300m';
      case SprintDistance.m400:
        return '400m';
      case SprintDistance.m500:
        return '500m';
      case SprintDistance.m600:
        return '600m';
    }
  }

  int get meters {
    switch (this) {
      case SprintDistance.m30:
        return 30;
      case SprintDistance.m40:
        return 40;
      case SprintDistance.m60:
        return 60;
      case SprintDistance.m100:
        return 100;
      case SprintDistance.m150:
        return 150;
      case SprintDistance.m200:
        return 200;
      case SprintDistance.m300:
        return 300;
      case SprintDistance.m400:
        return 400;
      case SprintDistance.m500:
        return 500;
      case SprintDistance.m600:
        return 600;
    }
  }

  static SprintDistance fromString(String value) {
    return SprintDistance.values.firstWhere(
      (dist) => dist.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => SprintDistance.m60,
    );
  }

  static SprintDistance fromMeters(int meters) {
    return SprintDistance.values.firstWhere(
      (dist) => dist.meters == meters,
      orElse: () => SprintDistance.m60,
    );
  }
}
