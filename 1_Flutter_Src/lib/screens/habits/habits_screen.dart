import 'package:flutter/material.dart';
import 'package:growth_fuel/config/theme.dart';
import 'package:growth_fuel/screens/habits/add_habit_screen.dart';
import 'package:intl/intl.dart';
import 'habit_type_widgets.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  DateTime _selectedDate = DateTime.now();

  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Habits',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.accent,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      key: const Key('add_habit_main'), // Add key for test
                      icon: const Icon(
                        Icons.add,
                        color: AppTheme.backgroundDark,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddHabitScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Date Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppTheme.textMuted,
                    ),
                    onPressed: () => _changeDate(-1),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: AppTheme.textMuted,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat(
                            'EEEE, MMM d',
                          ).format(_selectedDate).toUpperCase(),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      color: AppTheme.textMuted,
                    ),
                    onPressed: () => _changeDate(1),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Habits List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _ReadHabitCard(
                    icon: '📚',
                    title: 'Reading',
                    isCompleted: false,
                  ),
                  _DurationalHabitCard(
                    icon: '🧘',
                    title: 'Meditation',
                    isCompleted: true,
                  ),
                  _CountHabitCard(
                    icon: '💧',
                    title: 'Drink Water',
                    count: 4,
                    isCompleted: false,
                  ),
                  _TaskHabitCard(
                    icon: '💇',
                    title: 'Hair Care',
                    isCompleted: false,
                  ),
                  _TaskHabitCard(
                    icon: '🏃',
                    title: 'Morning Run',
                    isCompleted: false,
                    isDisabled: true,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Read Habit Card
class _ReadHabitCard extends StatefulWidget {
  final String icon;
  final String title;
  final bool isCompleted;

  const _ReadHabitCard({
    required this.icon,
    required this.title,
    required this.isCompleted,
  });

  @override
  State<_ReadHabitCard> createState() => _ReadHabitCardState();
}

class _ReadHabitCardState extends State<_ReadHabitCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
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
                  Text(widget.icon, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppTheme.textMuted,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0', style: Theme.of(context).textTheme.bodyLarge),
                    Text('Pages', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Durational Habit Card
class _DurationalHabitCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool isCompleted;

  const _DurationalHabitCard({
    required this.icon,
    required this.title,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                isCompleted ? Icons.pause : Icons.play_arrow,
                color: AppTheme.backgroundDark,
              ),
              onPressed: () {
                // TODO: Start/stop timer
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Count Habit Card
class _CountHabitCard extends StatefulWidget {
  final String icon;
  final String title;
  final int count;
  final bool isCompleted;

  const _CountHabitCard({
    required this.icon,
    required this.title,
    required this.count,
    required this.isCompleted,
  });

  @override
  State<_CountHabitCard> createState() => _CountHabitCardState();
}

class _CountHabitCardState extends State<_CountHabitCard> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(widget.icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.remove, color: AppTheme.textMuted),
              onPressed: () {
                setState(() {
                  if (_count > 0) _count--;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$_count',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: AppTheme.backgroundDark),
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Task Habit Card
class _TaskHabitCard extends StatefulWidget {
  final String icon;
  final String title;
  final bool isCompleted;
  final bool isDisabled;

  const _TaskHabitCard({
    required this.icon,
    required this.title,
    required this.isCompleted,
    this.isDisabled = false,
  });

  @override
  State<_TaskHabitCard> createState() => _TaskHabitCardState();
}

class _TaskHabitCardState extends State<_TaskHabitCard> {
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Opacity(
        opacity: widget.isDisabled ? 0.5 : 1.0,
        child: Row(
          children: [
            Text(widget.icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  decoration: widget.isDisabled
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            InkWell(
              onTap: widget.isDisabled
                  ? null
                  : () {
                      setState(() {
                        _isCompleted = !_isCompleted;
                      });
                    },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _isCompleted ? AppTheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _isCompleted ? AppTheme.primary : AppTheme.textMuted,
                    width: 2,
                  ),
                ),
                child: _isCompleted
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
      ),
    );
  }
}
