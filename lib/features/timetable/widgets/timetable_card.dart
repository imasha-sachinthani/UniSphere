import 'package:flutter/material.dart';

import '../models/timetable_model.dart';

class TimetableCard extends StatelessWidget {
  final TimetableModel timetable;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TimetableCard({
    super.key,
    required this.timetable,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final Color subjectColor = Color(timetable.color);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(
              color: subjectColor,
              width: 6,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                CircleAvatar(
                  radius: 8,
                  backgroundColor: subjectColor,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    timetable.subject,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "edit") {
                      onEdit();
                    } else if (value == "delete") {
                      onDelete();
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: "edit",
                      child: Text("Edit"),
                    ),
                    PopupMenuItem(
                      value: "delete",
                      child: Text("Delete"),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                const Icon(Icons.person, size: 18),
                const SizedBox(width: 8),
                Text(timetable.lecturer),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.room, size: 18),
                const SizedBox(width: 8),
                Text(timetable.room),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.access_time, size: 18),
                const SizedBox(width: 8),
                Text(
                  "${timetable.startTime} - ${timetable.endTime}",
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 8),
                Text(timetable.day),
              ],
            ),
          ],
        ),
      ),
    );
  }
}