import 'package:flutter/material.dart';

import '../controllers/assignment_controller.dart';
import '../models/assignment_model.dart';

class AddAssignmentDialog extends StatefulWidget {
  final AssignmentModel? assignment;

  const AddAssignmentDialog({
    super.key,
    this.assignment,
  });

  @override
  State<AddAssignmentDialog> createState() =>
      _AddAssignmentDialogState();
}

class _AddAssignmentDialogState
    extends State<AddAssignmentDialog> {

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final moduleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime deadline = DateTime.now();

  int priority = 2;

  bool completed = false;

  @override
  void initState() {
    super.initState();

    if (widget.assignment != null) {
      final a = widget.assignment!;

      titleController.text = a.title;
      moduleController.text = a.module;
      descriptionController.text = a.description;

      deadline = a.deadline;
      priority = a.priority;
      completed = a.completed;
    }
  }

  Future<void> saveAssignment() async {
    if (!formKey.currentState!.validate()) return;

    final assignment = AssignmentModel(
      id: widget.assignment?.id ?? "",
      title: titleController.text.trim(),
      module: moduleController.text.trim(),
      description: descriptionController.text.trim(),
      deadline: deadline,
      completed: completed,
      priority: priority,
    );

    if (widget.assignment == null) {
      await AssignmentController.addAssignment(
        assignment,
      );
    } else {
      await AssignmentController.updateAssignment(
        widget.assignment!.id,
        assignment,
      );
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

      title: Text(
        widget.assignment == null
            ? "Add Assignment"
            : "Edit Assignment",
      ),

      content: SizedBox(
        width: 420,

        child: Form(
          key: formKey,

          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Assignment Title",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: moduleController,
                  decoration: const InputDecoration(
                    labelText: "Module",
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                ),

                const SizedBox(height: 20),

                ListTile(
                  title: const Text("Deadline"),

                  subtitle: Text(
                    "${deadline.day}/${deadline.month}/${deadline.year}",
                  ),

                  trailing: const Icon(Icons.calendar_today),

                  onTap: () async {

                    final picked =
                    await showDatePicker(
                      context: context,
                      initialDate: deadline,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2035),
                    );

                    if (picked != null) {
                      setState(() {
                        deadline = picked;
                      });
                    }
                  },
                ),

                const SizedBox(height: 10),

                DropdownButtonFormField<int>(
                  value: priority,

                  decoration: const InputDecoration(
                    labelText: "Priority",
                  ),

                  items: const [

                    DropdownMenuItem(
                      value: 1,
                      child: Text("Low"),
                    ),

                    DropdownMenuItem(
                      value: 2,
                      child: Text("Medium"),
                    ),

                    DropdownMenuItem(
                      value: 3,
                      child: Text("High"),
                    ),

                  ],

                  onChanged: (value) {
                    setState(() {
                      priority = value!;
                    });
                  },
                ),

                const SizedBox(height: 16),

                CheckboxListTile(
                  value: completed,

                  title: const Text("Completed"),

                  onChanged: (value) {
                    setState(() {
                      completed = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: saveAssignment,
          child: Text(
            widget.assignment == null
                ? "Save"
                : "Update",
          ),
        ),
      ],
    );
  }
}