import 'package:flutter/material.dart';
import 'dart:async';

class DurationalHabitCard extends StatefulWidget {
  final String habitName;
  final Duration initialDuration;
  final void Function(Duration) onDurationChanged;

  const DurationalHabitCard({
    Key? key,
    required this.habitName,
    this.initialDuration = Duration.zero,
    required this.onDurationChanged,
  }) : super(key: key);

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
            widget.onDurationChanged(_duration);
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
    return Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.habitName,
                    style: const TextStyle(
                      color: Color(0xFFD4C5A8),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatDuration(_duration),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, color: const Color(0xFFE85D04)),
              onPressed: _toggleTimer,
              tooltip: _isRunning ? 'Pause' : 'Play',
            ),
          ],
        ),
      ),
    );
  }
}