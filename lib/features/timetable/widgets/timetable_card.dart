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
    final Color subjectColor = Color(timetable.color);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withValues(alpha: 0.35)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            width: 6,
            height: 155,
            decoration: BoxDecoration(
              color: subjectColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      CircleAvatar(
                        radius: 18,
                        backgroundColor:
                        subjectColor.withOpacity(.15),
                        child: Icon(
                          Icons.menu_book,
                          color: subjectColor,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          timetable.subject,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [

                      Icon(
                        Icons.access_time,
                        size: 18,
                        color: Theme.of(context).hintColor,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        "${timetable.startTime} - ${timetable.endTime}",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      Icon(
                        Icons.person,
                        size: 18,
                        color: Theme.of(context).hintColor,
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          timetable.lecturer,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      Icon(
                        Icons.location_on,
                        size: 18,
                        color: Theme.of(context).hintColor,
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          timetable.room,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Chip(
                      backgroundColor: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF2A2A2A)
                          : Colors.grey.shade100,
                      avatar: Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: Text(
                        timetable.day,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}