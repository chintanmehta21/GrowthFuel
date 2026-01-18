// GrowthFuel Widget Tests
// Tests for the GrowthFuel fitness and habit tracking application

import 'package:flutter_test/flutter_test.dart';

import 'package:growth_fuel/main.dart';

void main() {
  testWidgets('App loads and displays home screen', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title exists
    expect(
      find.text('GrowthFuel'),
      findsNothing,
    ); // App title is not visible on screen

    // Verify that we can find the home screen greeting
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Hello Chintan,'), findsOneWidget);

    // Verify that score cards are present
    expect(find.text('Workout\nScore'), findsOneWidget);
    expect(find.text('Habit\nScore'), findsOneWidget);
  });

  testWidgets('Bottom navigation bar works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify bottom navigation items exist
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Exercise'), findsOneWidget);
    expect(find.text('Habits'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Tap on Exercise tab
    await tester.tap(find.text('Exercise'));
    await tester.pumpAndSettle();

    // Verify we're on the Exercise tab
    expect(find.text('Push'), findsOneWidget);
    expect(find.text('Pull'), findsOneWidget);
    expect(find.text('FINISH'), findsOneWidget);
  });

  testWidgets('Navigation to Habits tab works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap on Habits tab
    await tester.tap(find.text('Habits'));
    await tester.pumpAndSettle();

    // Verify we're on the Habits tab
    expect(find.text('My Habits'), findsOneWidget);
  });

  testWidgets('Navigation to Profile tab works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap on Profile tab
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    // Verify we're on the Profile tab
    expect(find.text('Chintan'), findsOneWidget);
    expect(find.text('Preferences'), findsOneWidget);
    expect(find.text('Dark Mode'), findsOneWidget);
  });
}
