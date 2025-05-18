import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traak/constants/spacing.dart';
import 'package:traak/features/track/components/track_screen_empty_state.dart';
import 'package:traak/features/track/models/routine.dart';
import 'package:traak/features/track/repositories/routine_repository.dart';
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
            onPressed: () => context.push('/new-routine'),
            child: const Icon(Icons.add),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              // Manual refresh still available via pull-to-refresh
              await _routineRepository.getAllRoutines();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(Spacing.body),
              itemCount: routines.length,
              itemBuilder: (context, index) {
                final routine = routines[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: Spacing.md),
                  child: ListTile(
                    title: Text(routine.name),
                    subtitle: Text(
                      '${routine.type} • ${routine.exerciseCount} exercises',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteRoutine(routine.id),
                    ),
                    onTap: () {
                      // TODO: Navigate to routine detail
                    },
                  ),
                );
              },
            ),
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
