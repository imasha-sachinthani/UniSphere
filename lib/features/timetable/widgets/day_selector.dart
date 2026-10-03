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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = selectedDay == day;

          return ChoiceChip(
            label: Text(
              day,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),

            selected: isSelected,

            showCheckmark: false,

            backgroundColor: isDark
                ? const Color(0xFF2A2A2A)
                : Colors.grey.shade100,

            selectedColor: Theme.of(context).colorScheme.primary,

            side: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).dividerColor,
            ),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),

            onSelected: (_) {
              onDayChanged(day);
            },
          );
        },
      ),
    );
  }
}