import 'package:flutter/material.dart';
import 'package:growth_fuel/config/theme.dart';
import 'package:growth_fuel/utils/constants.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  String _selectedHabitType = HabitTypes.task;
  final TextEditingController _habitNameController = TextEditingController();
  String _category = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: AppTheme.textMain),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Add New Habit',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48), // Placeholder for balance
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Habit Name Input
                    Text(
                      'Habit Name',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textMain,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: AppTheme.textMain),
                            decoration: InputDecoration(
                              hintText: 'e.g., Morning Run',
                              filled: true,
                              fillColor: AppTheme.surfaceDark,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            controller: _habitNameController,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.emoji_emotions_outlined,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Category Selector
                    Text(
                      'Category',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textMain,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _category.isEmpty ? null : _category,
                          hint: const Text(
                            'Select category',
                            style: TextStyle(color: AppTheme.textMuted),
                          ),
                          dropdownColor: AppTheme.surfaceDark,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppTheme.textMuted,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Health',
                              child: Text(
                                'Health',
                                style: TextStyle(color: AppTheme.textMain),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Learning',
                              child: Text(
                                'Learning',
                                style: TextStyle(color: AppTheme.textMain),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Fitness',
                              child: Text(
                                'Fitness',
                                style: TextStyle(color: AppTheme.textMain),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _category = value ?? '';
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Habit Type Grid
                    Text(
                      'Habit Type',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        _HabitTypeCard(
                          icon: Icons.access_time_filled,
                          label: 'Durational',
                          isSelected:
                              _selectedHabitType == HabitTypes.durational,
                          onTap: () => setState(
                            () => _selectedHabitType = HabitTypes.durational,
                          ),
                        ),
                        _HabitTypeCard(
                          icon: Icons.menu_book,
                          label: 'Read',
                          isSelected: _selectedHabitType == HabitTypes.read,
                          onTap: () => setState(
                            () => _selectedHabitType = HabitTypes.read,
                          ),
                        ),
                        _HabitTypeCard(
                          icon: Icons.check_circle,
                          label: 'Task',
                          isSelected: _selectedHabitType == HabitTypes.task,
                          onTap: () => setState(
                            () => _selectedHabitType = HabitTypes.task,
                          ),
                        ),
                        _HabitTypeCard(
                          icon: Icons.onetwothree,
                          label: 'Count',
                          isSelected: _selectedHabitType == HabitTypes.count,
                          onTap: () => setState(
                            () => _selectedHabitType = HabitTypes.count,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Text(
                      _getHabitTypeDescription(_selectedHabitType),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Create Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Functionality to add habit
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Create Habit',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.backgroundDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getHabitTypeDescription(String type) {
    switch (type) {
      case HabitTypes.durational:
        return 'Track time spent on an activity.';
      case HabitTypes.read:
        return 'Track pages read or chapters completed.';
      case HabitTypes.task:
        return 'A simple task that you mark as done or not done.';
      case HabitTypes.count:
        return 'Track how many times you perform an activity.';
      default:
        return '';
    }
  }
}

class _HabitTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _HabitTypeCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: AppTheme.accent, width: 2)
              : null,
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.accent.withValues(alpha: 0.2)
                          : AppTheme.surfaceLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: isSelected ? AppTheme.accent : AppTheme.textMuted,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected ? AppTheme.accent : AppTheme.textMain,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppTheme.accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 10,
                    color: AppTheme.backgroundDark,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
