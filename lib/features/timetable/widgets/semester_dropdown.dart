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
      decoration: InputDecoration(
        labelText: "Semester",
        prefixIcon: const Icon(Icons.school),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      items: semesters.map((semester) {
        return DropdownMenuItem(
          value: semester,
          child: Text(semester),
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