import 'package:flutter/material.dart';
import 'package:growth_fuel/config/theme.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  void _changeMonth(int months) {
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month + months,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textMain),
          onPressed: () {},
        ),
        title: Text(
          'History',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppTheme.accent,
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: AppTheme.backgroundDark,
              unselectedLabelColor: AppTheme.textMuted,
              tabs: const [
                Tab(text: 'Daily'),
                Tab(text: 'Weekly'),
                Tab(text: 'Monthly'),
              ],
            ),
          ),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _DailyView(
                  selectedDate: _selectedDate,
                  onDateChange: _changeDate,
                ),
                _WeeklyView(),
                _MonthlyView(
                  selectedMonth: _selectedMonth,
                  onMonthChange: _changeMonth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Daily View
class _DailyView extends StatelessWidget {
  final DateTime selectedDate;
  final Function(int) onDateChange;

  const _DailyView({required this.selectedDate, required this.onDateChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date Navigation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: AppTheme.textMuted),
                onPressed: () => onDateChange(-1),
              ),
              Text(
                DateFormat('EEEE, MMM d').format(selectedDate),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textMuted,
                ),
                onPressed: () => onDateChange(1),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              // Workouts Section
              Text('Workouts', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              _WorkoutCard(
                category: 'Push',
                exercises: '5 Exercises',
                duration: '45 min',
                isCompleted: true,
              ),
              const SizedBox(height: 24),

              // Habits Section
              Text('Habits', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _HabitCompletionCard(
                      icon: '📚',
                      title: 'Reading',
                      isCompleted: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _HabitCompletionCard(
                      icon: '🧘',
                      title: 'Meditation',
                      isCompleted: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _HabitCompletionCard(
                      icon: '💧',
                      title: 'Drink Water',
                      isCompleted: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _HabitCompletionCard(
                      icon: '💇',
                      title: 'Hair Care',
                      isCompleted: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Workout Card
class _WorkoutCard extends StatelessWidget {
  final String category;
  final String exercises;
  final String duration;
  final bool isCompleted;

  const _WorkoutCard({
    required this.category,
    required this.exercises,
    required this.duration,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accent, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.fitness_center,
              color: AppTheme.accent,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  '$exercises • $duration',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (isCompleted)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppTheme.backgroundDark,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}

// Habit Completion Card
class _HabitCompletionCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool isCompleted;

  const _HabitCompletionCard({
    required this.icon,
    required this.title,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const Spacer(),
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppTheme.backgroundDark,
                    size: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isCompleted ? 'COMPLETED' : 'NOT COMPLETED',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isCompleted ? AppTheme.accent : AppTheme.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Weekly View
class _WeeklyView extends StatefulWidget {
  @override
  State<_WeeklyView> createState() => _WeeklyViewState();
}

class _WeeklyViewState extends State<_WeeklyView> {
  // Sample week data
  final List<Map<String, dynamic>> _weekData = [
    {
      'day': 'MON',
      'date': 15,
      'workout': 'Push',
      'duration': '30 min',
      'status': 'Completed',
      'habits': ['📚 Reading', '💧 Drink Water'],
    },
    {
      'day': 'TUE',
      'date': 16,
      'workout': 'Pull',
      'duration': '30 min',
      'status': 'Completed',
      'habits': ['🧘 Meditation', '💧 Drink Water'],
    },
    {
      'day': 'WED',
      'date': 17,
      'workout': 'Active Recovery',
      'duration': '',
      'status': 'Rest Day',
      'habits': ['📚 Reading'],
    },
    {
      'day': 'THU',
      'date': 18,
      'workout': 'Upper',
      'duration': '40 min',
      'status': 'Completed',
      'habits': ['💧 Drink Water', '🧘 Meditation', '📚 Reading'],
    },
    {
      'day': 'FRI',
      'date': 19,
      'workout': 'Lower',
      'duration': '40 min',
      'status': 'Completed',
      'habits': ['💇 Hair Care', '🧘 Meditation'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Week Range Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Week of Oct 15 - Oct 21',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppTheme.textMuted),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _weekData.length,
            itemBuilder: (context, index) {
              final day = _weekData[index];
              return _WeeklyDayCard(
                day: day['day'],
                date: day['date'],
                workout: day['workout'],
                duration: day['duration'],
                status: day['status'],
                habits: List<String>.from(day['habits']),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WeeklyDayCard extends StatelessWidget {
  final String day;
  final int date;
  final String workout;
  final String duration;
  final String status;
  final List<String> habits;

  const _WeeklyDayCard({
    required this.day,
    required this.date,
    required this.workout,
    required this.duration,
    required this.status,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    final bool isRestDay = status == 'Rest Day';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Date Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$day\n$date',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // Workout Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isRestDay ? AppTheme.textMuted : AppTheme.accent,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isRestDay
                            ? AppTheme.textMuted.withValues(alpha: 0.2)
                            : AppTheme.accent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isRestDay ? Icons.spa : Icons.fitness_center,
                        color: isRestDay ? AppTheme.textMuted : AppTheme.accent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (duration.isNotEmpty)
                            Text(
                              '$duration • $status',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppTheme.accent),
                            ),
                        ],
                      ),
                    ),
                    if (!isRestDay)
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppTheme.accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: AppTheme.backgroundDark,
                          size: 16,
                        ),
                      ),
                  ],
                ),

                // Habits
                if (habits.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: habits.map((habit) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceLight,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          habit,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Monthly View
class _MonthlyView extends StatelessWidget {
  final DateTime selectedMonth;
  final Function(int) onMonthChange;

  const _MonthlyView({
    required this.selectedMonth,
    required this.onMonthChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Month Navigation
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: AppTheme.textMain),
                onPressed: () => onMonthChange(-1),
              ),
              Text(
                DateFormat('MMMM yyyy').format(selectedMonth),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: AppTheme.textMain),
                onPressed: () => onMonthChange(1),
              ),
            ],
          ),
        ),

        // Calendar Grid
        Expanded(child: _CalendarGrid(month: selectedMonth)),
      ],
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final DateTime month;

  const _CalendarGrid({required this.month});

  @override
  Widget build(BuildContext context) {
    // Calculate calendar data
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final startWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday

    // Sample workout data for demo (day -> workout category)
    final workoutData = {
      3: 'Push',
      5: 'Pull',
      8: 'Push',
      11: 'Push',
      16: 'Pull',
      19: 'Pull',
      23: 'Push',
      26: 'Pull',
      29: 'Push',
    };

    // Sample habit data (day -> list of habit icons)
    final habitData = {
      3: ['📚', '💧'],
      5: ['🧘'],
      8: ['📚', '💧', '🧘'],
      11: ['💧', '🧘'],
      16: ['📚', '💧'],
      19: ['📚'],
      23: ['📚', '💧'],
      26: ['💧', '💇'],
      29: ['📚', '💧', '🧘'],
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Weekday Headers
          Row(
            children: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),

          // Calendar Days
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 0.7,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: startWeekday + daysInMonth,
              itemBuilder: (context, index) {
                if (index < startWeekday) {
                  return Container(); // Empty cell
                }

                final day = index - startWeekday + 1;
                final hasWorkout = workoutData.containsKey(day);
                final habits = habitData[day] ?? [];

                return Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$day',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (hasWorkout) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.accent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            workoutData[day]!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: AppTheme.backgroundDark,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                      if (habits.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Wrap(
                          spacing: 2,
                          runSpacing: 2,
                          children: habits.take(3).map((habit) {
                            return Text(
                              habit,
                              style: const TextStyle(fontSize: 10),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
