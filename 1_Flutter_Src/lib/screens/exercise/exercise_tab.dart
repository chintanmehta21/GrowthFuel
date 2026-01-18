import 'package:flutter/material.dart';
import 'package:growth_fuel/config/theme.dart';
import 'package:growth_fuel/utils/constants.dart';

class ExerciseTab extends StatefulWidget {
  const ExerciseTab({super.key});

  @override
  State<ExerciseTab> createState() => _ExerciseTabState();
}

class _ExerciseTabState extends State<ExerciseTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: ExerciseCategories.all.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundDark,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Workout : 16/01',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '0:40',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                // TODO: Finish workout
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                backgroundColor: Colors.transparent,
              ),
              child: Text(
                'FINISH',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppTheme.accent),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: AppTheme.backgroundDark,
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              indicatorColor: AppTheme.accent,
              indicatorWeight: 2,
              labelColor: AppTheme.primary,
              unselectedLabelColor: AppTheme.textMuted,
              labelStyle: Theme.of(context).textTheme.labelLarge,
              tabs: ExerciseCategories.all.map((category) {
                return Tab(text: category);
              }).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: ExerciseCategories.all.map((category) {
          return _ExerciseCategoryView(category: category);
        }).toList(),
      ),
    );
  }
}

class _ExerciseCategoryView extends StatelessWidget {
  final String category;

  const _ExerciseCategoryView({required this.category});

  @override
  Widget build(BuildContext context) {
    final exercises = ExerciseNames.byCategory[category] ?? [];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: exercises.length + 1, // +1 for Add Exercise button
      itemBuilder: (context, index) {
        if (index == exercises.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: OutlinedButton(
              onPressed: () {
                // TODO: Add new exercise
              },
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
  final List<Map<String, dynamic>> _sets = [
    {
      'set': 1,
      'previous': '60kg x 8',
      'weight': '',
      'reps': '',
      'completed': false,
    },
  ];

  void _addSet() {
    setState(() {
      _sets.add({
        'set': _sets.length + 1,
        'previous': '60kg x 8',
        'weight': '',
        'reps': '',
        'completed': false,
      });
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
          // Exercise Header
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

          // Sets List (when expanded)
          if (_isExpanded) ...[
            const Divider(height: 1, color: AppTheme.surfaceLight),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header Row
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

                  // Sets
                  ..._sets.map(
                    (set) => _SetRow(
                      setNumber: set['set'],
                      previousWeight: set['previous'],
                      isCompleted: set['completed'],
                      onComplete: () {
                        setState(() {
                          set['completed'] = !set['completed'];
                        });
                      },
                    ),
                  ),

                  // Add Set Button
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

class _SetRow extends StatelessWidget {
  final int setNumber;
  final String previousWeight;
  final bool isCompleted;
  final VoidCallback onComplete;

  const _SetRow({
    required this.setNumber,
    required this.previousWeight,
    required this.isCompleted,
    required this.onComplete,
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
              '$setNumber',
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
            onTap: onComplete,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isCompleted ? AppTheme.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isCompleted ? AppTheme.accent : AppTheme.textMuted,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: AppTheme.backgroundDark,
                      size: 16,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
