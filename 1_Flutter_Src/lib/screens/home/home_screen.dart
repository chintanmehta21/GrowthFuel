import 'package:flutter/material.dart';
import 'package:growth_fuel/config/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../widgets/score_card.dart';
import '../../widgets/section_with_dropdown.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final userName = user?.userMetadata?['name'] ?? user?.email?.split('@').first ?? 'User';
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello $userName,',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Score Cards Row
              Row(
                children: [
                  Expanded(
                    child: ScoreCard(
                      title: 'Workout Score',
                      icon: Icons.fitness_center,
                      score: 85, // Replace with actual value
                      iconColor: const Color(0xFFE85D04),
                      tooltipText: 'How is it calculated?',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ScoreCard(
                      title: 'Habit Score',
                      icon: Icons.check_circle,
                      score: 92, // Replace with actual value
                      iconColor: Colors.blue,
                      tooltipText: 'How is it calculated?',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Workout Counts Section with BarChart
              SectionWithDropdown(
                title: 'Workout Counts',
                initialTimePeriod: 'Weekly',
                onTimePeriodChanged: (value) {
                  // Handle workout time period change
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 10,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                                return Text(
                                  titles[value.toInt()],
                                  style: const TextStyle(
                                    color: Color(0xFFB0A090),
                                    fontSize: 12,
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5, color: const Color(0xFFD4C5A8), width: 12, borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)))]),
                          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 6, color: const Color(0xFFD4C5A8), width: 12, borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)))]),
                          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 3, color: const Color(0xFFD4C5A8), width: 12, borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)))]),
                          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 7, color: const Color(0xFFD4C5A8), width: 12, borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)))]),
                          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 4, color: const Color(0xFFD4C5A8), width: 12, borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)))]),
                          BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 8, color: const Color(0xFFD4C5A8), width: 12, borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)))]),
                          BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 5, color: const Color(0xFFD4C5A8), width: 12, borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)))]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Calories Burned Section with LineChart
              SectionWithDropdown(
                title: 'Calories Burned',
                initialTimePeriod: 'Weekly',
                onTimePeriodChanged: (value) {
                  // Handle calories time period change
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                                return Text(
                                  titles[value.toInt()],
                                  style: const TextStyle(
                                    color: Color(0xFFB0A090),
                                    fontSize: 12,
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 3),
                              FlSpot(1, 4),
                              FlSpot(2, 2),
                              FlSpot(3, 5),
                              FlSpot(4, 4),
                              FlSpot(5, 6),
                              FlSpot(6, 3),
                            ],
                            isCurved: true,
                            color: const Color(0xFFD4C5A8),
                            barWidth: 2,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: const Color(0xFFD4C5A8).withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Today's Plan
              Text(
                'Today\'s Plan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _TodaysPlanCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Today's Plan Card
class _TodaysPlanCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF9B59B6).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.fitness_center,
              color: Color(0xFF9B59B6),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upper Body',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '7 Exercises • 45 min',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow,
              color: AppTheme.accent,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
