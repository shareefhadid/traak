enum StartingPosition { twoPoint, threePoint, fourPoint, block, dropIn, flying }

extension StartingPositionExtension on StartingPosition {
  String get displayName {
    switch (this) {
      case StartingPosition.twoPoint:
        return 'Two-point';
      case StartingPosition.threePoint:
        return 'Three-point';
      case StartingPosition.fourPoint:
        return 'Four-point';
      case StartingPosition.block:
        return 'Block';
      case StartingPosition.dropIn:
        return 'Drop-in';
      case StartingPosition.flying:
        return 'Flying';
    }
  }

  static StartingPosition fromString(String value) {
    return StartingPosition.values.firstWhere(
      (position) => position.displayName.toLowerCase() == value.toLowerCase(),
      orElse: () => StartingPosition.block,
    );
  }
}
