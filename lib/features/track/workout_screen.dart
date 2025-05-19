import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/features/track/components/exercise_info_card.dart';
import 'package:traak/features/track/components/time_input_field.dart';
import 'package:traak/features/track/models/routine.dart';
import 'package:traak/features/track/models/workout.dart';
import 'package:traak/features/track/repositories/routine_repository.dart';
import 'package:traak/features/track/repositories/workout_repository.dart';
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

  @override
  void initState() {
    super.initState();
    _loadRoutine();
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
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

  void _nextRep() {
    if (_routine == null || _workout == null) return;

    final exercise = _routine!.exercises[_exerciseIndex];
    final result = _workoutRepo.recordRep(
      workout: _workout!,
      exercise: exercise,
      repNumber: _repNumber,
      timeInput: _timeController.text,
    );

    if (!result.success) {
      _showMessage(result.errorMessage!);
      return;
    }

    _timeController.clear();

    setState(() {
      if (_repNumber >= exercise.repCount) {
        if (_exerciseIndex >= _routine!.exercises.length - 1) {
          _completeWorkout();
        } else {
          _exerciseIndex++;
          _repNumber = 1;
        }
      } else {
        _repNumber++;
      }
    });
  }

  Future<void> _completeWorkout() async {
    if (_workout == null) return;

    try {
      final success = await _workoutRepo.completeWorkout(_workout!);
      if (!success) {
        _showMessage('Cannot complete empty workout');
        return;
      }

      _showMessage('Workout completed and saved');

      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      _showMessage('Error saving workout: $e');
    }
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

    return Scaffold(
      appBar: CustomAppBar(title: _routine!.name, onBack: _cancelWorkout),
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
                  child: ElevatedButton(
                    onPressed: _cancelWorkout,
                    child: const Text('Cancel workout'),
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        _isLastRep && _isLastExercise
                            ? _completeWorkout
                            : _nextRep,
                    child: Text(
                      _isLastRep && _isLastExercise
                          ? 'Complete workout'
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
