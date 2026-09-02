import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/assignment_model.dart';

class AssignmentCard extends StatelessWidget {
  final AssignmentModel assignment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const AssignmentCard({
    super.key,
    required this.assignment,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

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
    final deadline =
    DateFormat("dd MMM yyyy").format(assignment.deadline);

    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Expanded(
                  child: Text(
                    assignment.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: assignment.completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "edit") {
                      onEdit();
                    }

                    if (value == "delete") {
                      onDelete();
                    }
                  },
                  itemBuilder: (_) => const [
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

            const SizedBox(height: 8),

            Text(
              assignment.module,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              assignment.description,
            ),

            const SizedBox(height: 18),

            Row(
              children: [

                Chip(
                  backgroundColor:
                  getPriorityColor().withOpacity(.15),
                  label: Text(
                    getPriorityText(),
                    style: TextStyle(
                      color: getPriorityColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Spacer(),

                Text(
                  deadline,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: assignment.completed,
              onChanged: (_) => onToggle(),
              title: const Text("Completed"),
            ),
          ],
        ),
      ),
    );
  }
}