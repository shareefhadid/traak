import 'package:flutter/material.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/features/track/components/exercise_item.dart';
import 'package:traak/features/track/models/exercise.dart';
import 'package:traak/features/track/models/rep.dart';
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

  String _selectedType = 'Acceleration';

  // List of exercises, each with its own list of reps
  final List<Exercise> _exercises = [Exercise(id: 0)];

  final List<String> _routineTypes = [
    'Acceleration',
    'Max Velocity',
    'Tempo',
    'Endurance',
    'Recovery',
    'Technique',
  ];

  final List<String> _startingPositions = [
    'Standing',
    'Block',
    'Three-point',
    'Four-point',
    'Seated',
    'Lying',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    for (final exercise in _exercises) {
      exercise.distanceController.dispose();
    }
    super.dispose();
  }

  void _addExercise() {
    setState(() {
      _exercises.add(
        Exercise(id: _exercises.isEmpty ? 0 : _exercises.last.id + 1),
      );
    });
  }

  void _removeExercise(int index) {
    if (_exercises.length > 1) {
      setState(() {
        _exercises.removeAt(index);
      });
    }
  }

  void _addRep(int exerciseIndex) {
    setState(() {
      _exercises[exerciseIndex].reps.add(
        Rep(id: _exercises[exerciseIndex].reps.last.id + 1),
      );
    });
  }

  void _removeRep(int exerciseIndex, int repIndex) {
    if (_exercises[exerciseIndex].reps.length > 1) {
      setState(() {
        _exercises[exerciseIndex].reps.removeAt(repIndex);
      });
    }
  }

  void _saveRoutine() {
    if (_formKey.currentState!.validate()) {
      // Here you would save the routine to your database
      // For now, we just print the data
      debugPrint('Routine name: ${_nameController.text}');
      debugPrint('Type: $_selectedType');
      debugPrint('Exercises: ${_exercises.length}');

      for (final exercise in _exercises) {
        debugPrint('Exercise: ${exercise.name}');
        debugPrint('Distance: ${exercise.distanceController.text}');
        debugPrint('Effort: ${exercise.effort}%');
        debugPrint('Starting position: ${exercise.startingPosition}');
        debugPrint('Reps: ${exercise.reps.length}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Routine saved successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'New Routine'),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: AppBodyPadding(
            bottomOverride: Spacing.xl5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spacing.xl,
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
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  decoration: const InputDecoration(labelText: 'Routine Type'),
                  items:
                      _routineTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedType = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: Spacing.xs),
                const Text(
                  'Exercises',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _exercises.length,
                      itemBuilder: (context, exerciseIndex) {
                        return ExerciseItem(
                          exercise: _exercises[exerciseIndex],
                          exerciseIndex: exerciseIndex,
                          onRemove: () => _removeExercise(exerciseIndex),
                          onAddRep: () => _addRep(exerciseIndex),
                          onRemoveRep:
                              (repIndex) => _removeRep(exerciseIndex, repIndex),
                          isRemovable: _exercises.length > 1,
                          startingPositions: _startingPositions,
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
