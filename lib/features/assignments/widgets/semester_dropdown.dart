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
    const semesters = [
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
        hintText: "Select Semester",
        prefixIcon: const Icon(Icons.school),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: semesters.map((semester) {
        return DropdownMenuItem<String>(
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