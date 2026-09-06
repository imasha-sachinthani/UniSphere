import 'package:flutter/material.dart';

class DaySelector extends StatelessWidget {
  final String selectedDay;
  final Function(String) onDayChanged;

  const DaySelector({
    super.key,
    required this.selectedDay,
    required this.onDayChanged,
  });

  static const List<String> days = [
    "All",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final day = days[index];

          final isSelected =
              selectedDay == day;

          return ChoiceChip(
            label: Text(day),
            selected: isSelected,
            showCheckmark: true,
            onSelected: (_) {
              onDayChanged(day);
            },
          );
        },
      ),
    );
  }
}