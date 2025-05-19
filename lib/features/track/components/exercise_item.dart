import 'package:flutter/material.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/features/track/models/exercise.dart';
import 'package:traak/features/track/types/starting_position.dart';
import 'package:traak/features/track/types/distance.dart';
import 'package:traak/features/track/view_models/exercise_view_model.dart';
import 'package:traak/shared/components/app_body_padding.dart';

class ExerciseItem extends StatefulWidget {
  const ExerciseItem({
    super.key,
    required this.exercise,
    required this.exerciseIndex,
    required this.onRemove,
    required this.isRemovable,
    required this.startingPositions,
  });
  final Exercise exercise;
  final int exerciseIndex;
  final VoidCallback onRemove;
  final bool isRemovable;
  final List<String> startingPositions;

  @override
  State<ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  late final ExerciseViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ExerciseViewModel(exercise: widget.exercise);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  StartingPosition _getPositionFromDisplayName(String displayName) {
    return StartingPosition.values.firstWhere(
      (pos) => pos.displayName == displayName,
      orElse: () => StartingPosition.block,
    );
  }

  String get _currentStartingPositionDisplayName {
    return widget.exercise.startingPosition.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: Spacing.sm),
      child: AppBodyPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Spacing.lg,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Exercise ${widget.exerciseIndex + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (widget.isRemovable)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      widget.onRemove();
                    },
                    tooltip: 'Remove exercise',
                    color: ColorScheme.of(context).onSurfaceVariant,
                  ),
              ],
            ),
            TextFormField(
              controller: _viewModel.nameController,
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
                hintText: 'E.g., Sprint, Skips, Bounds',
              ),
              onChanged: (value) {
                _viewModel.save();
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an exercise name';
                }
                return null;
              },
            ),
            DropdownButtonFormField<SprintDistance>(
              value: widget.exercise.distance,
              decoration: const InputDecoration(labelText: 'Distance'),
              items:
                  _viewModel.availableDistances.map((SprintDistance distance) {
                    return DropdownMenuItem<SprintDistance>(
                      value: distance,
                      child: Text(distance.displayName),
                    );
                  }).toList(),
              onChanged: (SprintDistance? newValue) {
                if (newValue != null) {
                  setState(() {
                    _viewModel.updateDistance(newValue);
                  });
                }
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spacing.sm,
              children: [
                const Text('Effort'),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        padding: const EdgeInsets.only(right: Spacing.lg),
                        value: widget.exercise.effort,
                        min: 5,
                        max: 100,
                        divisions: 19,
                        label: '${widget.exercise.effort.round()}%',
                        onChanged: (double value) {
                          setState(() {
                            widget.exercise.effort = value;
                          });
                        },
                      ),
                    ),
                    Text('${widget.exercise.effort.round()}%'),
                  ],
                ),
              ],
            ),
            DropdownButtonFormField<String>(
              value: _currentStartingPositionDisplayName,
              decoration: const InputDecoration(labelText: 'Starting Position'),
              items:
                  widget.startingPositions.map((String position) {
                    return DropdownMenuItem<String>(
                      value: position,
                      child: Text(position),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    widget.exercise.startingPosition =
                        _getPositionFromDisplayName(newValue);
                  });
                }
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Repetitions',
                  style: TextStyle(
                    fontSize: TextTheme.of(context).bodySmall?.fontSize,
                    color: ColorScheme.of(context).onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Spacing.xs),
                TextFormField(
                  controller: _viewModel.repCountController,
                  readOnly: true,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorScheme.of(context).outlineVariant,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorScheme.of(context).outlineVariant,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed:
                          widget.exercise.repCount > 1
                              ? () {
                                setState(() {
                                  _viewModel.updateRepCount(
                                    widget.exercise.repCount - 1,
                                  );
                                });
                              }
                              : null,
                      tooltip: 'Decrease reps',
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _viewModel.updateRepCount(
                            widget.exercise.repCount + 1,
                          );
                        });
                      },
                      tooltip: 'Increase reps',
                    ),
                  ),
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter number of reps';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if (int.parse(value) <= 0) {
                      return 'Rep count must be at least 1';
                    }
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
