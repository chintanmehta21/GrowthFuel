// Exercise Categories
class ExerciseCategories {
  static const String push = 'Push';
  static const String pull = 'Pull';
  static const String legs = 'Legs';
  static const String upper = 'Upper';
  static const String lower = 'Lower';

  static const List<String> all = [push, pull, legs, upper, lower];
}

// Exercise Names by Category
class ExerciseNames {
  static const Map<String, List<String>> byCategory = {
    ExerciseCategories.push: [
      'Bench Press',
      'Incline Bench Press',
      'Lateral Dumbbell Raise',
      'Cable Overhead Triceps Extension',
    ],
    ExerciseCategories.pull: [
      'Chest Supported Rows',
      'Lat Pulldown',
      'Barbell Curl',
      'Pull-up',
      'Wrist Curl',
    ],
    ExerciseCategories.legs: [
      'Hack Squat',
      'Lying Leg Curl',
      'Standing Calf Raise',
      'Seated Leg Curls',
    ],
    ExerciseCategories.upper: [
      'Cable Tricep Pushdown',
      'Dumbbell Bench Press',
      'Barbell Row',
      'Seated Incline Dumbbell Press',
    ],
    ExerciseCategories.lower: [
      'Deadlift',
      'Seated Leg Curl',
      'Leg Extension',
      'Standing Calf Raises',
    ],
  };
}

// Habit Types
class HabitTypes {
  static const String durational = 'Durational';
  static const String read = 'Read';
  static const String task = 'Task';
  static const String count = 'Count';

  static const List<String> all = [durational, read, task, count];
}

// Navigation Indices
class NavigationIndex {
  static const int home = 0;
  static const int exercise = 1;
  static const int habits = 2;
  static const int history = 3;
  static const int profile = 4;
}

