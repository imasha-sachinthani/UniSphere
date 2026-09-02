import 'package:flutter/material.dart';

import '../controllers/assignment_controller.dart';
import '../models/assignment_model.dart';
import '../widgets/add_assignment_dialog.dart';
import '../widgets/assignment_card.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignments"),
        centerTitle: true,
      ),

      body: StreamBuilder<List<AssignmentModel>>(
        stream: AssignmentController.getAssignments(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          final assignments = snapshot.data ?? [];

          if (assignments.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.assignment,
                    size: 90,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    "No Assignments Yet",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Tap + to create your first assignment.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: assignments.length,
            itemBuilder: (context, index) {

              final assignment = assignments[index];

              return AssignmentCard(
                assignment: assignment,

                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddAssignmentDialog(
                      assignment: assignment,
                    ),
                  );
                },

                onDelete: () async {

                  final delete = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Delete Assignment"),
                      content: const Text(
                        "Are you sure you want to delete this assignment?",
                      ),
                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("Cancel"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text("Delete"),
                        ),

                      ],
                    ),
                  );

                  if (delete == true) {
                    await AssignmentController.deleteAssignment(
                      assignment.id,
                    );
                  }
                },

                onToggle: () async {

                  final updated = AssignmentModel(
                    id: assignment.id,
                    title: assignment.title,
                    module: assignment.module,
                    description: assignment.description,
                    deadline: assignment.deadline,
                    priority: assignment.priority,
                    completed: !assignment.completed,
                  );

                  await AssignmentController.updateAssignment(
                    assignment.id,
                    updated,
                  );
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddAssignmentDialog(),
          );
        },
      ),
    );
  }
}