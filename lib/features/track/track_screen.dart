import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/features/track/components/track_screen_empty_state.dart';
import 'package:traak/shared/models/routine.dart';
import 'package:traak/shared/repositories/routine_repository.dart';
import 'package:traak/features/track/types/routine_type.dart';
import 'package:traak/shared/components/custom_app_bar.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  final _routineRepository = RoutineRepository.instance;
  late final Stream<List<Routine>> _routinesStream;

  @override
  void initState() {
    super.initState();
    _routinesStream = _routineRepository.watchAllRoutines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Routine>>(
      stream: _routinesStream,
      builder: (context, snapshot) {
        // Show loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            appBar: CustomAppBar(title: 'Track'),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Show error state
        if (snapshot.hasError) {
          debugPrint('Error loading routines: ${snapshot.error}');
          return Scaffold(
            appBar: const CustomAppBar(title: 'Track'),
            body: Center(
              child: Text('Error loading routines: ${snapshot.error}'),
            ),
          );
        }

        final routines = snapshot.data ?? [];

        // Show empty state when no routines exist
        if (routines.isEmpty) {
          return const TrackScreenEmptyState();
        }

        // Show routines list
        return Scaffold(
          appBar: const CustomAppBar(title: 'Track'),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.goNamed('new-routine'),
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(Spacing.body),
            itemCount: routines.length,
            itemBuilder: (context, index) {
              final routine = routines[index];
              return Card(
                margin: const EdgeInsets.only(bottom: Spacing.md),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(routine.name),
                      subtitle: Text(
                        '${routine.type.displayName} • ${routine.exerciseCount} exercises',
                      ),
                      trailing: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_horiz),
                        onSelected: (value) {
                          if (value == 'edit') {
                            context.goNamed(
                              'edit-routine',
                              pathParameters: {'id': routine.id.toString()},
                            );
                          } else if (value == 'delete') {
                            _deleteRoutine(routine.id);
                          }
                        },
                        itemBuilder:
                            (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, size: 20),
                                    SizedBox(width: 8),
                                    Text('Edit'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, size: 20),
                                    SizedBox(width: 8),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                            ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Spacing.md,
                        right: Spacing.md,
                        bottom: Spacing.md,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed:
                                  () => {
                                    context.goNamed(
                                      'workout',
                                      pathParameters: {
                                        'id': routine.id.toString(),
                                      },
                                    ),
                                  },
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Start Workout'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ColorScheme.of(context).primaryContainer,
                                foregroundColor:
                                    ColorScheme.of(context).onPrimaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _deleteRoutine(int id) async {
    try {
      await _routineRepository.deleteRoutine(id);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Routine deleted')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error deleting routine: $e')));
      }
    }
  }
}
