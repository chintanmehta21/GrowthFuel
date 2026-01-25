import 'package:flutter/material.dart';
import 'package:growth_fuel/config/theme.dart';
import 'dart:async';

class ExerciseTab extends StatefulWidget {
  const ExerciseTab({super.key});

  @override
  State<ExerciseTab> createState() => _ExerciseTabState();
}

class _ExerciseTabState extends State<ExerciseTab> {
  String? _selectedWorkout;

  @override
  Widget build(BuildContext context) {
    if (_selectedWorkout == null) {
      return _WorkoutSelectionScreen(
        onWorkoutSelected: (workout) {
          setState(() {
            _selectedWorkout = workout;
          });
        },
      );
    }

    return _ExerciseTabContent(
      selectedWorkout: _selectedWorkout!,
      onWorkoutComplete: () {
        setState(() {
          _selectedWorkout = null;
        });
      },
    );
  }
}

class _WorkoutSelectionScreen extends StatefulWidget {
  final Function(String) onWorkoutSelected;

  const _WorkoutSelectionScreen({required this.onWorkoutSelected});

  @override
  State<_WorkoutSelectionScreen> createState() =>
      _WorkoutSelectionScreenState();
}

class _WorkoutSelectionScreenState extends State<_WorkoutSelectionScreen> {
  String? _selectedWorkout;

  // Static list of workouts - no external dependencies
  final List<String> workouts = ['Push', 'Pull', 'Legs', 'Upper', 'Lower'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What workout are you planning to do today?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _selectedWorkout != null
                        ? AppTheme.accent
                        : AppTheme.surfaceLight,
                    width: 1.5,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedWorkout,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Text(
                        'Select a workout',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(Icons.expand_more, color: AppTheme.accent),
                    ),
                    dropdownColor: AppTheme.surfaceDark,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppTheme.textMain),
                    items: workouts.map((workout) {
                      return DropdownMenuItem<String>(
                        value: workout,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Text(workout),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedWorkout = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedWorkout != null
                      ? () {
                          widget.onWorkoutSelected(_selectedWorkout!);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accent,
                    disabledBackgroundColor: AppTheme.accent.withValues(
                      alpha: 0.4,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Start',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.backgroundDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseTabContent extends StatefulWidget {
  final String selectedWorkout;
  final VoidCallback onWorkoutComplete;

  const _ExerciseTabContent({
    required this.selectedWorkout,
    required this.onWorkoutComplete,
  });

  @override
  State<_ExerciseTabContent> createState() => _ExerciseTabContentState();
}

class _ExerciseTabContentState extends State<_ExerciseTabContent> {
  Timer? _timer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedSeconds++;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _finishWorkout() {
    _timer?.cancel();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceDark,
          title: Text(
            'Workout Complete!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            'Duration: ${_formatTime(_elapsedSeconds)}\nWorkout: ${widget.selectedWorkout}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                // Resume timer if they don't finish?
                // The old logic stopped timer.
                // If they cancel dialog, we might want to resume.
                // For now, let's restart it if they cancel.
                _startTimer();
              },
              child: Text(
                'CANCEL',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppTheme.textMuted),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onWorkoutComplete();
              },
              child: Text(
                'FINISH',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppTheme.accent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header with Top Padding
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Workout : ${widget.selectedWorkout}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ElevatedButton(
                    onPressed: _finishWorkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 2, // Reduced vertical padding further
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'FINISH',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppTheme.backgroundDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Timer moved to top, smaller and closer to header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                4,
                24,
                16,
              ), // Reduced top padding
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _formatTime(_elapsedSeconds),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    // Smaller font
                    color: AppTheme.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 17, // Reduced font size further
                  ),
                ),
              ),
            ),

            // Exercise List
            Expanded(
              child: _ExerciseListView(category: widget.selectedWorkout),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseListView extends StatelessWidget {
  final String category;

  const _ExerciseListView({required this.category});

  @override
  Widget build(BuildContext context) {
    // Sample exercises - replace with actual data later
    final exercises = ['Bench Press', 'Squats', 'Deadlifts', 'Rows'];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: exercises.length + 1,
      itemBuilder: (context, index) {
        if (index == exercises.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.accent),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'ADD EXERCISE',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppTheme.accent),
              ),
            ),
          );
        }
        return _ExerciseCard(exerciseName: exercises[index]);
      },
    );
  }
}

class _ExerciseCard extends StatefulWidget {
  final String exerciseName;

  const _ExerciseCard({required this.exerciseName});

  @override
  State<_ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<_ExerciseCard> {
  bool _isExpanded = false;
  final List<Map<String, String>> _sets = [
    {'set': '1', 'previous': '60kg x 8', 'completed': 'false'},
  ];

  void _addSet() {
    setState(() {
      _sets.add({'set': '${_sets.length + 1}', 'previous': '60kg x 8'});
    });
  }

  void _removeSet(int index) {
    setState(() {
      _sets.removeAt(index);
      // Re-number sets
      for (int i = 0; i < _sets.length; i++) {
        _sets[i]['set'] = '${i + 1}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isExpanded ? AppTheme.accent : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.exerciseName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: AppTheme.accent,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.more_vert, color: AppTheme.textMuted, size: 20),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            const Divider(height: 1, color: AppTheme.surfaceLight),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Text(
                          'SET',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'PREVIOUS',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          'KG',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          'REPS',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._sets.asMap().entries.map(
                    (entry) => _SetItem(
                      setNumber: entry.value['set']!,
                      previousWeight: entry.value['previous']!,
                      onDelete: () => _removeSet(entry.key),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: _addSet,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppTheme.textMuted.withValues(alpha: 0.3),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          size: 16,
                          color: AppTheme.textMuted,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'ADD SET',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SetItem extends StatelessWidget {
  final String setNumber;
  final String previousWeight;
  final VoidCallback onDelete;

  const _SetItem({
    required this.setNumber,
    required this.previousWeight,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              setNumber,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: Text(
              previousWeight,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(
            width: 60,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '60',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '8',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onDelete,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              child: const Icon(
                Icons.delete_outline,
                color: AppTheme.textMuted,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
