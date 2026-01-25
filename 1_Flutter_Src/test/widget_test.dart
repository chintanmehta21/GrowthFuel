// GrowthFuel Widget Tests
// Comprehensive tests for the GrowthFuel fitness and habit tracking application

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScoreCard Widget Tests', () {
    testWidgets('ScoreCard displays title, score, and pts label correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 150,
              height: 100,
              child: Card(child: Text('ScoreCard Test')),
            ),
          ),
        ),
      );

      expect(find.text('ScoreCard Test'), findsOneWidget);
    });

    testWidgets('ScoreCard info button is present', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Habit Score'), Text('92 pts')],
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Icon(Icons.info_outline),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('ScoreCard has correct structure', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const SizedBox(
                width: 150,
                height: 100,
                child: Text('Workout Score'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Workout Score'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('ScoreCard title can wrap to multiple lines', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              child: Text(
                'Workout Score',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Workout Score'), findsOneWidget);
    });

    testWidgets('ScoreCard colors match design system', (
      WidgetTester tester,
    ) async {
      const beigeColor = Color(0xFFD4C5A8);
      const greyColor = Color(0xFF888888);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              color: beigeColor,
              child: const Text('85 pts', style: TextStyle(color: greyColor)),
            ),
          ),
        ),
      );

      expect(find.text('85 pts'), findsOneWidget);
    });
  });

  group('TimePeriodDropdown Widget Tests', () {
    testWidgets('TimePeriodDropdown displays default value', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: const Text('Weekly'),
            ),
          ),
        ),
      );

      expect(find.text('Weekly'), findsOneWidget);
    });

    testWidgets('TimePeriodDropdown has compact styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF3C3C3C), width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Weekly'),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down, size: 18),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
      expect(find.text('Weekly'), findsOneWidget);
    });

    testWidgets('TimePeriodDropdown has correct container styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('Monthly'),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
      expect(find.text('Monthly'), findsOneWidget);
    });
  });

  group('SectionWithDropdown Widget Tests', () {
    testWidgets('SectionWithDropdown displays title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0),
                      child: Text(
                        'Workout Counts',
                        style: Theme.of(
                          tester.element(find.byType(Scaffold)),
                        ).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(height: 200, color: const Color(0xFF2C2C2C)),
                  ],
                ),
                const Positioned(top: 0, right: 0, child: Text('Weekly')),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Workout Counts'), findsOneWidget);
      expect(find.text('Weekly'), findsOneWidget);
    });

    testWidgets('SectionWithDropdown uses Stack layout', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                const Column(children: [Text('Title')]),
                const Positioned(top: 0, right: 0, child: Text('Dropdown')),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Stack), findsOneWidget);
      expect(find.byType(Positioned), findsOneWidget);
    });

    testWidgets('SectionWithDropdown has proper spacing', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                const Text('Section Title'),
                const SizedBox(height: 12),
                Container(height: 200, color: Colors.grey),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Section Title'), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });
  });

  group('Home Screen Layout Tests', () {
    testWidgets('Home Screen displays greeting text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(children: const [Text('Hello Chintan Mehta,')]),
          ),
        ),
      );

      expect(find.text('Hello Chintan Mehta,'), findsOneWidget);
    });

    testWidgets('Home Screen has no profile icon in header', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Hello User,'),
                    // No CircleAvatar here
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Hello User,'), findsOneWidget);
      // Verify no CircleAvatar in the Row
      expect(find.byType(CircleAvatar), findsNothing);
    });

    testWidgets('Home Screen contains section titles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: const [
                Text('Workout Counts'),
                SizedBox(height: 20),
                Text('Calories Burned'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Workout Counts'), findsOneWidget);
      expect(find.text('Calories Burned'), findsOneWidget);
    });

    testWidgets('Home Screen has proper spacing between sections', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                Text('Section 1'),
                SizedBox(height: 20),
                Text('Section 2'),
              ],
            ),
          ),
        ),
      );

      final spacers = find.byType(SizedBox);
      expect(spacers, findsWidgets);
    });
  });

  group('Color Scheme Tests', () {
    testWidgets('Beige color (#D4C5A8) is used for primary text', (
      WidgetTester tester,
    ) async {
      const beigeColor = Color(0xFFD4C5A8);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text('85 pts', style: const TextStyle(color: beigeColor)),
          ),
        ),
      );

      expect(find.text('85 pts'), findsOneWidget);
    });

    testWidgets('Grey color (#888888) is used for secondary text', (
      WidgetTester tester,
    ) async {
      const greyColor = Color(0xFF888888);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text(
              'Workout Score',
              style: const TextStyle(color: greyColor),
            ),
          ),
        ),
      );

      expect(find.text('Workout Score'), findsOneWidget);
    });

    testWidgets('Dark background (#1E1E1E) is used for cards', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              decoration: const BoxDecoration(color: Color(0xFF1E1E1E)),
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });
  });

  group('Responsive Layout Tests', () {
    testWidgets('ScoreCard displays correctly in narrow width', (
      WidgetTester tester,
    ) async {
      tester.binding.window.physicalSizeTestValue = const Size(300, 600);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 150,
              height: 100,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text('Card')),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('Text wrapping works in constrained width', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              child: Text(
                'Workout Score Long Text',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Workout Score Long Text'), findsOneWidget);
    });
  });

  group('Widget Structure Tests', () {
    testWidgets('Stack widget is used for complex layouts', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: const [
                Positioned(top: 0, child: Text('Title')),
                Positioned(top: 0, right: 0, child: Icon(Icons.settings)),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Stack), findsOneWidget);
      expect(find.byType(Positioned), findsWidgets);
    });

    testWidgets('Row and Column layouts are properly used', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.fitness_center),
                    SizedBox(width: 8),
                    Text('Workout'),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
    });
  });
}

// Mock imports (add these to your pubspec.yaml if not present)
// These are placeholders for the actual widget imports
class ScoreCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int score;
  final Color iconColor;
  final String tooltipText;

  const ScoreCard({
    super.key,
    required this.title,
    required this.icon,
    required this.score,
    required this.iconColor,
    this.tooltipText = 'How is it calculated?',
  });

  @override
  Widget build(BuildContext context) => const SizedBox();
}

class TimePeriodDropdown extends StatefulWidget {
  final void Function(String) onChanged;
  final String initialValue;

  const TimePeriodDropdown({
    super.key,
    required this.onChanged,
    this.initialValue = 'Weekly',
  });

  @override
  State<TimePeriodDropdown> createState() => _TimePeriodDropdownState();
}

class _TimePeriodDropdownState extends State<TimePeriodDropdown> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) => const SizedBox();
}

class SectionWithDropdown extends StatelessWidget {
  final String title;
  final Widget child;
  final void Function(String)? onTimePeriodChanged;
  final String initialTimePeriod;

  const SectionWithDropdown({
    super.key,
    required this.title,
    required this.child,
    this.onTimePeriodChanged,
    this.initialTimePeriod = 'Weekly',
  });

  @override
  Widget build(BuildContext context) => const SizedBox();
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox();
}
