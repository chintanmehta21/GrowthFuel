import 'package:flutter/material.dart';
import 'time_period_dropdown.dart';

class SectionWithDropdown extends StatelessWidget {
  final String title;
  final Widget child;
  final void Function(String)? onTimePeriodChanged;
  final String initialTimePeriod;

  const SectionWithDropdown({
    Key? key,
    required this.title,
    required this.child,
    this.onTimePeriodChanged,
    this.initialTimePeriod = 'Weekly',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Content Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with spacing for dropdown
            Padding(
              padding: const EdgeInsets.only(right: 80.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFD4C5A8),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
            // Child widget (chart, etc.)
            child,
          ],
        ),
        // Dropdown pinned to top-right
        Positioned(
          top: 0,
          right: 0,
          child: TimePeriodDropdown(
            initialValue: initialTimePeriod,
            onChanged: onTimePeriodChanged ?? (_) {},
          ),
        ),
      ],
    );
  }
}
