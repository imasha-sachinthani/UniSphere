import 'package:flutter/material.dart';

class SemesterDropdown extends StatelessWidget {
  final String selectedSemester;
  final ValueChanged<String> onChanged;

  const SemesterDropdown({
    super.key,
    required this.selectedSemester,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final semesters = [
      "All",
      "Semester 1",
      "Semester 2",
      "Semester 3",
      "Semester 4",
      "Semester 5",
      "Semester 6",
      "Semester 7",
      "Semester 8",
    ];

    return DropdownButtonFormField<String>(
      value: selectedSemester,

      dropdownColor: Theme.of(context).cardColor,

      iconEnabledColor: Theme.of(context).hintColor,

      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontSize: 16,
      ),

      decoration: InputDecoration(
        labelText: "Semester",

        labelStyle: TextStyle(
          color: Theme.of(context).hintColor,
        ),

        filled: true,
        fillColor: Theme.of(context).cardColor,

        prefixIcon: Icon(
          Icons.school,
          color: Theme.of(context).hintColor,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),

      items: semesters.map((semester) {
        return DropdownMenuItem<String>(
          value: semester,
          child: Text(
            semester,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        );
      }).toList(),

      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}