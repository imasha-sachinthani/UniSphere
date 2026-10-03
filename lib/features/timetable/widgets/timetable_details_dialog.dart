import 'package:flutter/material.dart';

import '../models/timetable_model.dart';

class TimetableDetailsDialog extends StatelessWidget {
  final TimetableModel timetable;

  const TimetableDetailsDialog({
    super.key,
    required this.timetable,
  });

  Widget buildRow(
      BuildContext context,
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color:
                    Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_month,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 20),

            Text(
              timetable.subject,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),

            const SizedBox(height: 24),

            buildRow(
              context,
              Icons.person,
              "Lecturer",
              timetable.lecturer,
            ),

            buildRow(
              context,
              Icons.room,
              "Room",
              timetable.room,
            ),

            buildRow(
              context,
              Icons.school,
              "Semester",
              timetable.semester,
            ),

            buildRow(
              context,
              Icons.calendar_today,
              "Day",
              timetable.day,
            ),

            buildRow(
              context,
              Icons.access_time,
              "Time",
              "${timetable.startTime} - ${timetable.endTime}",
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}