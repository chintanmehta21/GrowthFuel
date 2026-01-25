import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF3C3C3C), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: DropdownButton<String>(
        value: _selectedValue,
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedValue = newValue;
            });
            widget.onChanged(newValue);
          }
        },
        items: ['Weekly', 'Monthly', 'Custom'].map<DropdownMenuItem<String>>((
          String value,
        ) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFFD4C5A8),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          );
        }).toList(),
        underline: const SizedBox(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: const Color(0xFFD4C5A8),
          size: 18,
        ),
        dropdownColor: const Color(0xFF2C2C2C),
        style: const TextStyle(
          color: Color(0xFFD4C5A8),
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        isDense: true,
        isExpanded: false,
      ),
    );
  }
}
