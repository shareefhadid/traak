import 'package:flutter/material.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/features/track/models/exercise.dart';
import 'package:traak/shared/components/app_body_padding.dart';

class ExerciseItem extends StatefulWidget {
  const ExerciseItem({
    super.key,
    required this.exercise,
    required this.exerciseIndex,
    required this.onRemove,
    required this.onAddRep,
    required this.onRemoveRep,
    required this.isRemovable,
    required this.startingPositions,
  });
  final Exercise exercise;
  final int exerciseIndex;
  final VoidCallback onRemove;
  final VoidCallback onAddRep;
  final Function(int) onRemoveRep;
  final bool isRemovable;
  final List<String> startingPositions;

  @override
  State<ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
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
                    icon: const Icon(Icons.delete),
                    onPressed: widget.onRemove,
                    tooltip: 'Remove exercise',
                    color: Colors.red,
                  ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
                hintText: 'E.g., Sprint, Skips, Bounds',
              ),
              onChanged: (value) {
                widget.exercise.name = value;
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an exercise name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: widget.exercise.distanceController,
              decoration: const InputDecoration(
                labelText: 'Distance (meters)',
                hintText: 'Enter distance in meters',
                suffixText: 'm',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a distance';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                if (int.parse(value) <= 0) {
                  return 'Distance must be greater than 0';
                }
                return null;
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
              value: widget.exercise.startingPosition,
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
                    widget.exercise.startingPosition = newValue;
                  });
                }
              },
            ),
            Text(
              'Reps (${widget.exercise.reps.length})',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.exercise.reps.length,
              itemBuilder: (context, repIndex) {
                return Card(
                  color: ColorScheme.of(context).surfaceContainerHighest,
                  margin: const EdgeInsets.symmetric(vertical: Spacing.xs),
                  child: AppBodyPadding.horizontal(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Rep ${repIndex + 1} Notes',
                              hintText: 'Optional notes',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              widget.exercise.reps[repIndex].notes = value;
                            },
                          ),
                        ),
                        if (widget.exercise.reps.length > 1)
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () => widget.onRemoveRep(repIndex),
                            tooltip: 'Remove rep',
                            color: Colors.red,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            TextButton.icon(
              onPressed: widget.onAddRep,
              icon: const Icon(Icons.add),
              label: const Text('Add Rep'),
            ),
          ],
        ),
      ),
    );
  }
}
