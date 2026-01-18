import 'package:flutter/material.dart';
import 'package:growth_fuel/config/theme.dart';
import 'package:growth_fuel/screens/home/home_screen.dart';
import 'package:growth_fuel/screens/exercise/exercise_tab.dart';
import 'package:growth_fuel/screens/habits/habits_screen.dart';
import 'package:growth_fuel/screens/history/history_screen.dart';
import 'package:growth_fuel/screens/profile/profile_screen.dart';
import 'package:growth_fuel/widgets/bottom_navigation.dart';
import 'package:growth_fuel/utils/constants.dart';

import 'package:flutter/foundation.dart'; // For kReleaseMode
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GrowthFuel',
      theme: AppTheme.darkTheme,
      // DevicePreview settings
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = NavigationIndex.home;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ExerciseTab(),
    const HabitsScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
