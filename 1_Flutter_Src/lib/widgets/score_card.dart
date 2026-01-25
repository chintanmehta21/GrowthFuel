import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Main Card Content
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Top row: Icon and Title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Icon(icon, color: iconColor, size: 18),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF888888),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.clip,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                // Bottom: Score and pts
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$score',
                      style: const TextStyle(
                        color: Color(0xFFD4C5A8),
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      'pts',
                      style: TextStyle(
                        color: const Color(0xFFB0A090),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Info Button - Positioned at bottom right
          Positioned(
            bottom: 8,
            right: 8,
            child: Tooltip(
              message: tooltipText,
              triggerMode: TooltipTriggerMode.longPress,
              preferBelow: false,
              textStyle: const TextStyle(color: Colors.white),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
              ),
              child: InkWell(
                onTap: () {
                  // Optional: Add tap handler
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
