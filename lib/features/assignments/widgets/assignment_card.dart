import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/assignment_model.dart';

class AssignmentCard extends StatelessWidget {
  final AssignmentModel assignment;

  const AssignmentCard({
    super.key,
    required this.assignment,
  });

  String getStatus() {
    if (assignment.completed) {
      return "Completed";
    }

    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final due = DateTime(
      assignment.deadline.year,
      assignment.deadline.month,
      assignment.deadline.day,
    );

    final difference =
        due.difference(today).inDays;

    if (difference < 0) {
      return "Overdue";
    }

    if (difference == 0) {
      return "Due Today";
    }

    if (difference == 1) {
      return "Tomorrow";
    }

    return "$difference Days Left";
  }

  Color getStatusColor() {
    if (assignment.completed) {
      return Colors.green;
    }

    final status = getStatus();

    if (status == "Overdue") {
      return Colors.red;
    }

    if (status == "Due Today") {
      return Colors.orange;
    }

    if (status == "Tomorrow") {
      return Colors.blue;
    }

    return Colors.green;
  }

  Color getPriorityColor() {
    switch (assignment.priority) {
      case 3:
        return Colors.red;

      case 2:
        return Colors.orange;

      default:
        return Colors.green;
    }
  }

  String getPriorityText() {
    switch (assignment.priority) {
      case 3:
        return "High";

      case 2:
        return "Medium";

      default:
        return "Low";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(18),
      ),
      child: Padding(
        padding:
        const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                CircleAvatar(
                  radius: 22,
                  backgroundColor:
                  Colors.blue.shade100,
                  child: const Icon(
                    Icons.assignment,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [

                      Text(
                        assignment.title,
                        style:
                        const TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        assignment.module,
                        style:
                        const TextStyle(
                          color:
                          Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.chevron_right,
                ),
              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: [

                const Icon(
                  Icons.person,
                  size: 18,
                  color: Colors.grey,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    assignment.lecturer,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [

                const Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.grey,
                ),

                const SizedBox(width: 8),

                Text(
                  DateFormat(
                    "dd MMM yyyy",
                  ).format(
                    assignment.deadline,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Row(
              children: [

                Container(
                  padding:
                  const EdgeInsets
                      .symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration:
                  BoxDecoration(
                    color:
                    getPriorityColor()
                        .withOpacity(
                        0.15),
                    borderRadius:
                    BorderRadius
                        .circular(
                      20,
                    ),
                  ),
                  child: Text(
                    getPriorityText(),
                    style: TextStyle(
                      color:
                      getPriorityColor(),
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

                const Spacer(),

                Container(
                  padding:
                  const EdgeInsets
                      .symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration:
                  BoxDecoration(
                    color:
                    getStatusColor()
                        .withOpacity(
                        0.15),
                    borderRadius:
                    BorderRadius
                        .circular(
                      20,
                    ),
                  ),
                  child: Text(
                    getStatus(),
                    style: TextStyle(
                      color:
                      getStatusColor(),
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}