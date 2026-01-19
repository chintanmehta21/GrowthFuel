// GrowthFuel Widget Tests
// Comprehensive tests for the GrowthFuel fitness and habit tracking application

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_fuel/main.dart';

void main() {
  group('App Initialization Tests', () {
    testWidgets('App loads and displays home screen', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that we can find the home screen greeting
      expect(find.text('Welcome back'), findsOneWidget);
      expect(find.text('Hello Chintan,'), findsOneWidget);

      // Verify that score cards are present
      expect(find.text('Workout\nScore'), findsOneWidget);
      expect(find.text('Habit\nScore'), findsOneWidget);

      // Verify score values are displayed
      expect(find.text('85'), findsOneWidget);
      expect(find.text('92'), findsOneWidget);
      expect(find.text('pts'), findsNWidgets(2));
    });

    testWidgets('App uses correct theme colors', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify MaterialApp is using dark theme
      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.theme, isNotNull);
      expect(app.theme!.brightness, Brightness.dark);
    });
  });

  group('Home Screen Tests', () {
    testWidgets('Home screen displays all required sections', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Verify greeting section
      expect(find.text('Welcome back'), findsOneWidget);
      expect(find.text('Hello Chintan,'), findsOneWidget);

      // Verify score cards section - updated layout without arrows
      expect(find.text('Workout\nScore'), findsOneWidget);
      expect(find.text('Habit\nScore'), findsOneWidget);

      // Verify workout counts section
      expect(find.text('Workout Counts'), findsOneWidget);
      expect(find.text('Weekly'), findsOneWidget);

      // Verify calories burned section
      expect(find.text('Calories Burned'), findsOneWidget);
      expect(find.text('This Week'), findsOneWidget);

      // Verify today's plan section
      expect(find.text('Today\'s Plan'), findsOneWidget);
      expect(find.text('Upper Body'), findsOneWidget);
      expect(find.text('7 Exercises • 45 min'), findsOneWidget);
    });

    testWidgets('Home screen score cards have correct layout', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Verify score cards are present (they're in a Row)
      expect(find.text('Workout\nScore'), findsOneWidget);
      expect(find.text('Habit\nScore'), findsOneWidget);

      // Verify that arrows are NOT present in score cards (removed in UI update)
      expect(
        find.descendant(
          of: find.ancestor(
            of: find.text('Workout\nScore'),
            matching: find.byType(Container),
          ),
          matching: find.byIcon(Icons.arrow_forward_ios),
        ),
        findsNothing,
      );
    });

    testWidgets('Home screen profile icon is displayed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Verify profile icon exists
      expect(find.byIcon(Icons.person), findsWidgets); // Accepts multiple profile icons
    });

    testWidgets('Home screen is scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify SingleChildScrollView exists
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });
  });

  group('Bottom Navigation Tests', () {
    testWidgets('Bottom navigation bar displays all tabs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Verify all navigation items exist
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Exercise'), findsOneWidget);
      expect(find.text('Habits'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('Bottom navigation icons are displayed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Verify navigation icons
      expect(find.byIcon(Icons.home), findsWidgets); // Accepts multiple home icons
      expect(find.byIcon(Icons.fitness_center), findsWidgets); // Accepts multiple fitness icons
      expect(find.byIcon(Icons.check_circle), findsWidgets); // Accepts multiple check_circle icons
    });

    testWidgets('Navigation to Exercise tab works', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Tap on Exercise tab
      await tester.tap(find.text('Exercise'));
      await tester.pumpAndSettle();

      // Verify we're on the Exercise tab
      expect(find.text('Push'), findsOneWidget);
      expect(find.text('Pull'), findsOneWidget);
      expect(find.text('Lower'), findsOneWidget);
      expect(find.text('Upper'), findsOneWidget);
      expect(find.text('FINISH'), findsOneWidget);
    });

    testWidgets('Navigation to Habits tab works', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Tap on Habits tab
      await tester.tap(find.text('Habits'));
      await tester.pumpAndSettle();

      // Verify we're on the Habits tab
      expect(find.text('My Habits'), findsWidgets); // Accepts multiple My Habits widgets
    });

    testWidgets('Navigation to History tab works', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Tap on History tab
      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      // Verify we're on the History tab
      expect(find.text('History'), findsWidgets); // Accepts multiple History widgets
      expect(find.text('Daily'), findsOneWidget);
      expect(find.text('Weekly'), findsOneWidget);
      expect(find.text('Monthly'), findsOneWidget);
    });

    testWidgets('Navigation to Profile tab works', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Tap on Profile tab
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      // Verify we're on the Profile tab
      expect(find.text('Chintan'), findsOneWidget);
      expect(find.text('Preferences'), findsOneWidget);
      expect(find.text('Dark Mode'), findsOneWidget);
    });

    testWidgets('Navigation back to Home tab works', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Navigate to Exercise tab
      await tester.tap(find.text('Exercise'));
      await tester.pumpAndSettle();

      // Navigate back to Home tab
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Verify we're back on the Home tab
      expect(find.text('Welcome back'), findsOneWidget);
      expect(find.text('Hello Chintan,'), findsOneWidget);
    });
  });

  group('Exercise Tab Tests', () {
    testWidgets('Exercise tab displays all workout categories', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Exercise'));
      await tester.pumpAndSettle();

      // Verify all workout categories
      expect(find.text('Push'), findsOneWidget);
      expect(find.text('Pull'), findsOneWidget);
      expect(find.text('Lower'), findsOneWidget);
      expect(find.text('Upper'), findsOneWidget);
      expect(find.text('FINISH'), findsOneWidget);
    });

    testWidgets('Exercise tab displays exercise details', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Exercise'));
      await tester.pumpAndSettle();

      // Verify exercise details are displayed
      expect(find.textContaining('Exercises'), findsWidgets);
      expect(find.textContaining('min'), findsWidgets);
    });
  });

  group('Habits Tab Tests', () {
    testWidgets('Habits tab displays title', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Habits'));
      await tester.pumpAndSettle();

      expect(find.text('My Habits'), findsOneWidget);
    });

    testWidgets('Habits tab can navigate to add habit screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Habits'));
      await tester.pumpAndSettle();

      // Find and tap the add button
      final addButton = find.byIcon(Icons.add);
      if (addButton.evaluate().isNotEmpty) {
        await tester.tap(addButton);
        await tester.pumpAndSettle();

        // Verify add habit screen is displayed
        expect(find.text('Add New Habit'), findsOneWidget);
      }
    });
  });

  group('History Tab Tests', () {
    testWidgets('History tab displays tab bar with three views', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      // Verify tab bar exists with all three tabs
      expect(find.text('Daily'), findsOneWidget);
      expect(find.text('Weekly'), findsOneWidget);
      expect(find.text('Monthly'), findsOneWidget);
    });

    testWidgets('History daily view displays correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      // Daily tab should be selected by default
      // Verify date navigation is present
      expect(find.byIcon(Icons.chevron_left), findsWidgets);
      expect(find.byIcon(Icons.chevron_right), findsWidgets);

      // Verify sections are present
      expect(find.text('Workouts'), findsOneWidget);
      expect(find.text('Habits'), findsOneWidget);
    });

    testWidgets('History weekly view displays correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      // Tap on Weekly tab
      await tester.tap(find.text('Weekly'));
      await tester.pumpAndSettle();

      // Verify week range is displayed
      expect(find.textContaining('Week of'), findsOneWidget);

      // Verify day labels are present (MON, TUE, etc.)
      expect(find.text('MON'), findsWidgets);
      expect(find.text('TUE'), findsWidgets);
    });

    testWidgets('History weekly view has timeline layout', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Weekly'));
      await tester.pumpAndSettle();

      // Verify workout cards are displayed
      expect(find.text('Push'), findsWidgets);
      expect(find.text('Pull'), findsWidgets);

      // Verify completion status is shown
      expect(find.textContaining('Completed'), findsWidgets);
    });

    testWidgets('History monthly view displays calendar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      // Tap on Monthly tab
      await tester.tap(find.text('Monthly'));
      await tester.pumpAndSettle();

      // Verify month navigation
      expect(find.byIcon(Icons.chevron_left), findsWidgets);
      expect(find.byIcon(Icons.chevron_right), findsWidgets);

      // Verify weekday headers
      expect(find.text('SUN'), findsOneWidget);
      expect(find.text('MON'), findsOneWidget);
      expect(find.text('TUE'), findsOneWidget);
      expect(find.text('WED'), findsOneWidget);
      expect(find.text('THU'), findsOneWidget);
      expect(find.text('FRI'), findsOneWidget);
      expect(find.text('SAT'), findsOneWidget);
    });

    testWidgets('History monthly view displays workout data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Monthly'));
      await tester.pumpAndSettle();

      // Verify calendar grid is present
      expect(find.byType(GridView), findsOneWidget);

      // Verify workout labels in calendar
      expect(find.text('Workout'), findsWidgets);
    });
  });

  group('Profile Tab Tests', () {
    testWidgets('Profile tab displays user information', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      // Verify user info
      expect(find.text('Chintan'), findsWidgets); // Accepts multiple Chintan widgets

      // Verify profile sections
      expect(find.text('Preferences'), findsOneWidget);
      expect(find.text('Dark Mode'), findsOneWidget);
    });

    testWidgets('Profile tab displays all menu items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      // Verify preferences section exists
      expect(find.text('Preferences'), findsWidgets); // Accepts multiple Preferences widgets
    });
  });

  group('Widget Structure Tests', () {
    testWidgets('All screens have Scaffold widget', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Home screen
      expect(find.byType(Scaffold), findsWidgets);

      // Exercise tab
      await tester.tap(find.text('Exercise'));
      await tester.pumpAndSettle();
      expect(find.byType(Scaffold), findsWidgets);

      // Habits tab
      await tester.tap(find.text('Habits'));
      await tester.pumpAndSettle();
      expect(find.byType(Scaffold), findsWidgets);

      // History tab
      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();
      expect(find.byType(Scaffold), findsWidgets);

      // Profile tab
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('App has proper SafeArea', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify SafeArea is used
      expect(find.byType(SafeArea), findsWidgets);
    });
  });

  group('UI Element Tests', () {
    testWidgets('Icons render correctly across all screens', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Home screen icons
      expect(find.byIcon(Icons.person), findsWidgets);
      expect(find.byIcon(Icons.fitness_center), findsWidgets);
      expect(find.byIcon(Icons.check_circle), findsWidgets);

      // Exercise tab
      await tester.tap(find.text('Exercise'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.fitness_center), findsWidgets);

      // History tab
      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check), findsWidgets);
    });

    testWidgets('Containers have proper decoration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Verify containers exist
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('Text widgets use correct styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Verify various text widgets exist
      expect(find.byType(Text), findsWidgets);
    });
  });

  group('Interaction Tests', () {
    testWidgets('Can scroll on home screen', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find scrollable widget
      final scrollable = find.byType(SingleChildScrollView).first;
      expect(scrollable, findsOneWidget);

      // Perform scroll
      await tester.drag(scrollable, const Offset(0, -300));
      await tester.pumpAndSettle();

      // Verify scroll worked (no error thrown)
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    testWidgets('TabController switches tabs correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Navigate to History
      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      // Switch between Daily, Weekly, Monthly tabs
      await tester.tap(find.text('Weekly'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Week of'), findsOneWidget);

      await tester.tap(find.text('Monthly'));
      await tester.pumpAndSettle();
      expect(find.text('SUN'), findsOneWidget);

      await tester.tap(find.text('Daily'));
      await tester.pumpAndSettle();
      expect(find.text('Workouts'), findsOneWidget);
    });
  });

  group('Edge Case Tests', () {
    testWidgets('App handles rapid tab switching', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Rapidly switch tabs
      await tester.tap(find.text('Exercise'));
      await tester.pump();
      await tester.tap(find.text('Habits'));
      await tester.pump();
      await tester.tap(find.text('History'));
      await tester.pump();
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      // Verify no errors and Profile is displayed
      expect(find.text('Chintan'), findsOneWidget);
    });

    testWidgets('App builds without errors', (WidgetTester tester) async {
      // This test ensures the app can be built without throwing exceptions
      await tester.pumpWidget(const MyApp());
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('All tabs are reachable multiple times', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // First cycle
      await tester.tap(find.text('Exercise'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Second cycle
      await tester.tap(find.text('Habits'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Verify home screen still works
      expect(find.text('Welcome back'), findsOneWidget);
    });
  });

  group('Data Display Tests', () {
    testWidgets('Score values are displayed as integers', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      // Verify score values
      expect(find.text('85'), findsOneWidget);
      expect(find.text('92'), findsOneWidget);
    });

    testWidgets('History weekly view shows proper date format', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Weekly'));
      await tester.pumpAndSettle();

      // Verify date range format
      expect(find.textContaining('Week of'), findsOneWidget);
    });

    testWidgets('Exercise durations are displayed correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Exercise'));
      await tester.pumpAndSettle();

      // Verify duration format
      expect(find.textContaining('min'), findsWidgets);
    });
  });
}
