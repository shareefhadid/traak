import 'package:flutter/material.dart';
import 'package:traak/constants/spacing.dart';

/// A widget that adds padding to its child equal to [Spacings.body].
///
/// You can override the padding in multiple ways:
/// * Using the `topOverride`, `bottomOverride`, `leftOverride`, and `rightOverride` parameters to specify the padding on each side of the child.
/// * Using the `vertical` constructor will only set top and bottom padding.
/// * Using the `horizontal` constructor will only set the left and right padding.
class AppBodyPadding extends StatelessWidget {
  /// The child widget to add padding to.
  final Widget child;

  /// Overrides the padding on the top side of the child widget.
  final double? topOverride;

  /// Overrides the padding on the bottom side of the child widget.
  final double? bottomOverride;

  /// Overrides the padding on the left side of the child widget.
  final double? leftOverride;

  /// Overrides the padding on the right side of the child widget.
  final double? rightOverride;

  /// Creates an [AppBodyPadding] widget.
  ///
  /// The `topOverride`, `bottomOverride`, `leftOverride`, and `rightOverride` parameters
  /// can be used to specify the padding on each side of the child. If any of these parameters are
  /// `null`, the default padding value defined in the `Spacings` class is used.
  const AppBodyPadding({
    super.key,
    required this.child,
    this.topOverride,
    this.bottomOverride,
    this.leftOverride,
    this.rightOverride,
  });

  /// Creates an [AppBodyPadding] widget.
  ///
  /// The `topOverride` and `bottomOverride` parameters can be used to specify the padding on
  /// the top and bottom sides of the child. If any of these parameters are
  /// `null`, the default padding value defined in the `Spacings` class is used.
  /// The left and right padding are set to 0.
  const AppBodyPadding.vertical({
    super.key,
    this.topOverride,
    this.bottomOverride,
    required this.child,
  }) : leftOverride = 0.0,
       rightOverride = 0.0;

  /// Creates an [AppBodyPadding] widget.
  ///
  /// The `leftOverride` and `rightOverride` parameters can be used to specify the padding on
  /// the top and bottom sides of the child. If any of these parameters are
  /// `null`, the default padding value defined in the `Spacings` class is used.
  /// The top and bottom padding are set to 0.
  const AppBodyPadding.horizontal({
    super.key,
    this.leftOverride,
    this.rightOverride,
    required this.child,
  }) : topOverride = 0.0,
       bottomOverride = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topOverride ?? Spacing.body,
        bottom: bottomOverride ?? Spacing.body,
        left: leftOverride ?? Spacing.body,
        right: rightOverride ?? Spacing.body,
      ),
      child: child,
    );
  }
}
