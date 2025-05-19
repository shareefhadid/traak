import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traak/shared/constants/spacing.dart';
import 'package:traak/features/track/components/exercise_item.dart';
import 'package:traak/shared/models/exercise.dart';
import 'package:traak/shared/models/routine.dart';
import 'package:traak/shared/repositories/routine_repository.dart';
import 'package:traak/features/track/types/routine_type.dart';
import 'package:traak/features/track/types/starting_position.dart';
import 'package:traak/shared/components/app_body_padding.dart';
import 'package:traak/shared/components/custom_app_bar.dart';

class NewRoutineScreen extends StatefulWidget {
  const NewRoutineScreen({super.key});

  @override
  State<NewRoutineScreen> createState() => _NewRoutineScreenState();
}

class _NewRoutineScreenState extends State<NewRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final _routineRepository = RoutineRepository.instance;

  RoutineType _selectedType = RoutineType.acceleration;

  final List<Exercise> _exercises = [Exercise()];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addExercise() {
    setState(() {
      _exercises.add(Exercise());
    });
  }

  void _removeExercise(String exerciseId) {
    if (_exercises.length > 1) {
      setState(() {
        _exercises.removeWhere((exercise) => exercise.uuid == exerciseId);
      });
    }
  }

  Future<void> _saveRoutine() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create routine object
        final routine =
            Routine()
              ..name = _nameController.text
              ..type = _selectedType
              ..exercises = _exercises;

        // Save to database
        await _routineRepository.saveRoutine(routine);
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Routine saved successfully')),
        );

        context.go('/');
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving routine: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'New Routine',
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveRoutine),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: AppBodyPadding(
            bottomOverride: Spacing.xl5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Routine Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Routine Name',
                    hintText: 'Enter routine name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a routine name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Spacing.xl),
                DropdownButtonFormField<RoutineType>(
                  value: _selectedType,
                  decoration: const InputDecoration(labelText: 'Routine Type'),
                  items:
                      RoutineType.values.map((RoutineType type) {
                        return DropdownMenuItem<RoutineType>(
                          value: type,
                          child: Text(type.displayName),
                        );
                      }).toList(),
                  onChanged: (RoutineType? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedType = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: Spacing.xl4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Spacing.sm,
                  children: [
                    const Text(
                      'Exercises',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: _exercises.length,
                      itemBuilder: (context, exerciseIndex) {
                        final exercise = _exercises[exerciseIndex];
                        return ExerciseItem(
                          key: ValueKey(exercise.uuid),
                          exercise: exercise,
                          exerciseIndex: exerciseIndex,
                          onRemove: () => _removeExercise(exercise.uuid),
                          isRemovable: _exercises.length > 1,
                          startingPositions:
                              StartingPosition.values
                                  .map((pos) => pos.displayName)
                                  .toList(),
                        );
                      },
                    ),
                    ElevatedButton.icon(
                      onPressed: _addExercise,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Exercise'),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveRoutine,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(Spacing.md),
                    ),
                    child: const Text('Save Routine'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
