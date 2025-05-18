import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/features/track/components/exercise_item.dart';
import 'package:traak/features/track/models/exercise.dart';
import 'package:traak/features/track/models/routine.dart';
import 'package:traak/features/track/repositories/routine_repository.dart';
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

  String _selectedType = 'Acceleration';

  final List<Exercise> _exercises = [Exercise()];

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
      appBar: const CustomAppBar(title: 'New Routine'),
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
