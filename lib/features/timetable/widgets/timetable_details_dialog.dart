import 'package:flutter/material.dart';

import '../models/timetable_model.dart';

class TimetableDetailsDialog extends StatelessWidget {
  final TimetableModel timetable;

  const TimetableDetailsDialog({
    super.key,
    required this.timetable,
  });

  Widget buildRow(
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
            color: Colors.blue,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.calendar_month,
              size: 60,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            Text(
              timetable.subject,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            buildRow(
              Icons.person,
              "Lecturer",
              timetable.lecturer,
            ),

            buildRow(
              Icons.room,
              "Room",
              timetable.room,
            ),

            buildRow(
              Icons.school,
              "Semester",
              timetable.semester,
            ),

            buildRow(
              Icons.calendar_today,
              "Day",
              timetable.day,
            ),

            buildRow(
              Icons.access_time,
              "Time",
              "${timetable.startTime} - ${timetable.endTime}",
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
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