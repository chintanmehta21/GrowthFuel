import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int score;
  final Color iconColor;
  final String tooltipText;

  const ScoreCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.score,
    required this.iconColor,
    this.tooltipText = 'How is it calculated?',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFFD4C5A8),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Tooltip(
                      message: tooltipText,
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.grey.shade400,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '$score pts',
                  style: const TextStyle(
                    color: Color(0xFFD4C5A8),
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}