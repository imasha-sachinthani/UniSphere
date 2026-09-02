import 'package:flutter/material.dart';

import '../models/timetable_model.dart';

class TimetableCard extends StatelessWidget {
  final TimetableModel timetable;

  const TimetableCard({
    super.key,
    required this.timetable,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.only(bottom: 16),

      child: ListTile(

        leading: CircleAvatar(
          backgroundColor:
          Color(timetable.color),
        ),

        title: Text(
          timetable.subject,
        ),

        subtitle: Text(
          "${timetable.startTime} - ${timetable.endTime}\n${timetable.room}",
        ),

        trailing: Text(
          timetable.day,
        ),

      ),
    );
  }
}