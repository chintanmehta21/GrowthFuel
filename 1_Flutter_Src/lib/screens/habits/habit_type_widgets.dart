import 'package:flutter/material.dart';
import 'dart:async';
import 'package:growth_fuel/config/theme.dart';

class DurationalHabitCard extends StatefulWidget {
  final String icon;
  final String title;
  final bool isCompleted;
  final Duration initialDuration;
  final void Function(Duration)? onDurationChanged;

  const DurationalHabitCard({
    super.key,
    required this.icon,
    required this.title,
    required this.isCompleted,
    this.initialDuration = Duration.zero,
    this.onDurationChanged,
  });

  @override
  State<DurationalHabitCard> createState() => _DurationalHabitCardState();
}

class _DurationalHabitCardState extends State<DurationalHabitCard> {
  late Duration _duration;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _duration = widget.initialDuration;
  }

  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        _timer?.cancel();
      } else {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _duration += const Duration(seconds: 1);
            widget.onDurationChanged?.call(_duration);
          });
        });
      }
      _isRunning = !_isRunning;
    });
  }

  String _formatDuration(Duration d) {
    int hours = d.inHours;
    int minutes = d.inMinutes % 60;
    int seconds = d.inSeconds % 60;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(widget.icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          // Timer Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE0D4), // Light beige
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _formatDuration(_duration),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Play/Pause Button
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                _isRunning ? Icons.pause : Icons.play_arrow,
                color: AppTheme.backgroundDark,
              ),
              onPressed: _toggleTimer,
            ),
          ),
        ],
      ),
    );
  }
}
