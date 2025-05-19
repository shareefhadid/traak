import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/features/track/components/exercise_info_card.dart';
import 'package:traak/features/track/components/time_input_field.dart';
import 'package:traak/shared/models/routine.dart';
import 'package:traak/shared/models/workout.dart';
import 'package:traak/shared/repositories/routine_repository.dart';
import 'package:traak/shared/repositories/workout_repository.dart';
import 'package:traak/shared/components/app_body_padding.dart';
import 'package:traak/shared/components/confirmation_dialog.dart';
import 'package:traak/shared/components/custom_app_bar.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key, required this.routineId});

  final int routineId;

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final _routineRepo = RoutineRepository.instance;
  final _workoutRepo = WorkoutRepository.instance;
  final _timeController = TextEditingController();

  Routine? _routine;
  Workout? _workout;
  int _exerciseIndex = 0;
  int _repNumber = 1;
  bool _isLoading = true;

  // Map of exercise indices to completed reps
  // Key: '$exerciseIndex:$repNumber', Value: time in seconds
  final Map<String, double> _completedReps = {};

  String _getPositionKey(int exerciseIndex, int repNumber) {
    return '$exerciseIndex:$repNumber';
  }

  @override
  void initState() {
    super.initState();
    _loadRoutine();
    _timeController.addListener(_handleTimeChange);
  }

  @override
  void dispose() {
    _timeController.removeListener(_handleTimeChange);
    _timeController.dispose();
    super.dispose();
  }

  void _handleTimeChange() {
    // Save the current time input as a draft
    if (_timeController.text.isNotEmpty) {}
  }

  Future<void> _loadRoutine() async {
    try {
      final routine = await _routineRepo.getRoutineById(widget.routineId);

      if (routine == null) {
        _showError('Routine not found');
        return;
      }

      setState(() {
        _routine = routine;
        _workout = _workoutRepo.createWorkoutFromRoutine(routine);
        _isLoading = false;
      });
    } catch (e) {
      _showError('Error loading routine: $e');
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    context.go('/');
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _saveWorkout({bool showConfirmation = true}) async {
    if (_routine == null || _workout == null) return;

    // Ensure the current rep is saved if there's a time value entered
    if (_timeController.text.isNotEmpty) {
      try {
        final time = double.parse(_timeController.text);
        if (time > 0) {
          final currentKey = _getPositionKey(_exerciseIndex, _repNumber);
          _completedReps[currentKey] = time;
        }
      } catch (_) {
        // Ignore invalid time inputs
      }
    }

    // Check if we have any reps to save
    if (_completedReps.isEmpty) {
      _showMessage('Cannot save empty workout');
      return;
    }

    // Show confirmation dialog if requested
    if (showConfirmation) {
      final confirmed = await ConfirmationDialog.show(
        context: context,
        title: 'Save Workout',
        message:
            'Are you sure you want to save this workout and end this session early?',
      );

      if (confirmed != true || !mounted) return;
    }

    try {
      _workout!.reps.clear();

      for (final entry in _completedReps.entries) {
        final parts = entry.key.split(':');
        final exerciseIndex = int.parse(parts[0]);
        final repNumber = int.parse(parts[1]);

        if (exerciseIndex < _routine!.exercises.length) {
          final exercise = _routine!.exercises[exerciseIndex];
          final rep =
              WorkoutRep()
                ..exerciseName = exercise.name
                ..distanceInMeters = exercise.distanceInMeters
                ..effort = exercise.effort
                ..startingPosition = exercise.startingPosition.toString()
                ..exerciseUuid = exercise.uuid
                ..repNumber = repNumber
                ..completionTime = entry.value;

          _workout!.reps.add(rep);
        }
      }

      final success = await _workoutRepo.completeWorkout(_workout!);
      if (!success) {
        _showMessage('Cannot save empty workout');
        return;
      }

      _showMessage('Workout saved successfully');

      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      _showMessage('Error saving workout: $e');
    }
  }

  bool _validateAndSaveCurrentRep() {
    if (_timeController.text.isEmpty) {
      _showMessage('Please enter a completion time for the current rep');
      return false;
    }

    try {
      final time = double.parse(_timeController.text);
      if (time <= 0) {
        _showMessage('Time must be positive');
        return false;
      }

      final currentKey = _getPositionKey(_exerciseIndex, _repNumber);
      _completedReps[currentKey] = time;
      return true;
    } catch (e) {
      _showMessage('Please enter a valid time in seconds');
      return false;
    }
  }

  void _nextRep() {
    if (_routine == null || _workout == null) return;

    // Record the current rep
    if (!_validateAndSaveCurrentRep()) {
      return;
    }

    setState(() {
      final exercise = _routine!.exercises[_exerciseIndex];
      if (_repNumber >= exercise.repCount) {
        if (_exerciseIndex >= _routine!.exercises.length - 1) {
          _saveAndCompleteWorkout();
        } else {
          _exerciseIndex++;
          _repNumber = 1;
        }
      } else {
        _repNumber++;
      }

      // Load any existing time for the new position
      final newKey = _getPositionKey(_exerciseIndex, _repNumber);
      if (_completedReps.containsKey(newKey)) {
        _timeController.text = _completedReps[newKey]!.toString();
      } else {
        _timeController.clear();
      }
    });
  }

  void _previousRep() {
    if (_routine == null || _workout == null) return;

    // Save the current time if valid
    if (_timeController.text.isNotEmpty) {
      try {
        final time = double.parse(_timeController.text);
        if (time > 0) {
          final currentKey = _getPositionKey(_exerciseIndex, _repNumber);
          _completedReps[currentKey] = time;
        }
      } catch (_) {
        // Ignore invalid time inputs
      }
    }

    setState(() {
      if (_repNumber > 1) {
        _repNumber--;
      } else if (_exerciseIndex > 0) {
        _exerciseIndex--;
        _repNumber = _routine!.exercises[_exerciseIndex].repCount;
      }

      // Load time for the previous position
      final prevKey = _getPositionKey(_exerciseIndex, _repNumber);
      if (_completedReps.containsKey(prevKey)) {
        _timeController.text = _completedReps[prevKey]!.toString();
      } else {
        _timeController.clear();
      }
    });
  }

  void _skipRep() {
    if (_routine == null || _workout == null) return;

    setState(() {
      final exercise = _routine!.exercises[_exerciseIndex];
      if (_repNumber >= exercise.repCount) {
        if (_exerciseIndex >= _routine!.exercises.length - 1) {
          // Can't skip the last rep of the last exercise
          _showMessage('Cannot skip the final rep');
          return;
        } else {
          _exerciseIndex++;
          _repNumber = 1;
        }
      } else {
        _repNumber++;
      }

      // Load any existing time for the new position
      final newKey = _getPositionKey(_exerciseIndex, _repNumber);
      if (_completedReps.containsKey(newKey)) {
        _timeController.text = _completedReps[newKey]!.toString();
      } else {
        _timeController.clear();
      }
    });
  }

  bool get _canGoPrevious {
    return _repNumber > 1 || _exerciseIndex > 0;
  }

  // Use the shared _saveWorkout method with no confirmation
  Future<void> _saveAndCompleteWorkout() async {
    await _saveWorkout(showConfirmation: false);
  }

  Future<void> _cancelWorkout() async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: 'Cancel Workout',
      message: 'Are you sure you want to cancel this workout?',
    );

    if (confirmed == true && mounted) {
      context.go('/');
    }
  }

  bool get _isLastRep {
    if (_routine == null) return true;
    final exercise = _routine!.exercises[_exerciseIndex];
    return _repNumber >= exercise.repCount;
  }

  bool get _isLastExercise {
    if (_routine == null) return true;
    return _exerciseIndex >= _routine!.exercises.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_routine == null) {
      return const Scaffold(body: Center(child: Text('Error loading workout')));
    }

    final exercise = _routine!.exercises[_exerciseIndex];

    // Determine if we're moving between sets or reps
    final goingToNextSet = _isLastRep && !_isLastExercise;
    final comingFromPreviousSet = _repNumber == 1 && _exerciseIndex > 0;

    // Check if we have any completed reps to save
    final hasCompletedReps = _completedReps.isNotEmpty;
    // Check if the current rep is the last rep of the last exercise
    final isLastRepOfWorkout = _isLastRep && _isLastExercise;

    return Scaffold(
      appBar: CustomAppBar(
        title: _routine!.name,
        onBack: _cancelWorkout,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'save':
                  _saveWorkout();
                  break;
                case 'skip':
                  _skipRep();
                  break;
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem<String>(
                    value: 'save',
                    enabled: hasCompletedReps,
                    child: const Row(
                      children: [
                        Icon(Icons.save),
                        SizedBox(width: 8),
                        Text('Save and end'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'skip',
                    enabled: !isLastRepOfWorkout,
                    child: Row(
                      children: [
                        const Icon(Icons.skip_next),
                        const SizedBox(width: 8),
                        Text(goingToNextSet ? 'Skip to next set' : 'Skip rep'),
                      ],
                    ),
                  ),
                ],
            icon: const Icon(Icons.more_horiz),
            tooltip: 'Workout options',
          ),
        ],
      ),
      body: AppBodyPadding(
        child: Column(
          children: [
            ExerciseInfoCard(exercise: exercise, currentRepNumber: _repNumber),
            const SizedBox(height: Spacing.xl),
            TimeInputField(controller: _timeController),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child:
                      _canGoPrevious
                          ? ElevatedButton(
                            onPressed: _previousRep,
                            child: Text(
                              comingFromPreviousSet
                                  ? 'Previous set'
                                  : 'Previous rep',
                            ),
                          )
                          : ElevatedButton(
                            onPressed: _cancelWorkout,
                            child: const Text('Cancel workout'),
                          ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        isLastRepOfWorkout
                            ? () {
                              // For the last rep, first validate and save it, then complete
                              if (_validateAndSaveCurrentRep()) {
                                _saveAndCompleteWorkout();
                              }
                            }
                            : _nextRep,
                    child: Text(
                      isLastRepOfWorkout
                          ? 'Complete workout'
                          : goingToNextSet
                          ? 'Next set'
                          : 'Next rep',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.md),
          ],
        ),
      ),
    );
  }
}
