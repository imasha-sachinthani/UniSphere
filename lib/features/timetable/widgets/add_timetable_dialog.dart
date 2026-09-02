import 'package:flutter/material.dart';

import '../controllers/timetable_controller.dart';
import '../models/timetable_model.dart';

class AddTimetableDialog extends StatefulWidget {
  final TimetableModel? timetable;

  const AddTimetableDialog({
    super.key,
    this.timetable,
  });

  @override
  State<AddTimetableDialog> createState() => _AddTimetableDialogState();
}

class _AddTimetableDialogState extends State<AddTimetableDialog> {
  final subjectController = TextEditingController();
  final lecturerController = TextEditingController();
  final roomController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  String selectedDay = "Monday";

  int selectedColor = Colors.blue.value;

  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ];

  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();

    if (widget.timetable != null) {
      subjectController.text = widget.timetable!.subject;
      lecturerController.text = widget.timetable!.lecturer;
      roomController.text = widget.timetable!.room;
      startTimeController.text = widget.timetable!.startTime;
      endTimeController.text = widget.timetable!.endTime;

      selectedDay = widget.timetable!.day;
      selectedColor = widget.timetable!.color;
    }
  }

  @override
  void dispose() {
    subjectController.dispose();
    lecturerController.dispose();
    roomController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (subjectController.text.trim().isEmpty ||
        lecturerController.text.trim().isEmpty ||
        roomController.text.trim().isEmpty ||
        startTimeController.text.trim().isEmpty ||
        endTimeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    final timetable = TimetableModel(
      id: widget.timetable?.id ?? "",
      subject: subjectController.text.trim(),
      lecturer: lecturerController.text.trim(),
      room: roomController.text.trim(),
      day: selectedDay,
      startTime: startTimeController.text.trim(),
      endTime: endTimeController.text.trim(),
      color: selectedColor,
    );

    if (widget.timetable == null) {
      await TimetableController.addTimetable(timetable);
    } else {
      await TimetableController.updateTimetable(
        widget.timetable!.id,
        timetable,
      );
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.timetable == null
            ? "Add Timetable"
            : "Edit Timetable",
      ),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: "Subject",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: lecturerController,
              decoration: const InputDecoration(
                labelText: "Lecturer",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: roomController,
              decoration: const InputDecoration(
                labelText: "Room",
              ),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: selectedDay,
              decoration: const InputDecoration(
                labelText: "Day",
              ),
              items: days.map((day) {
                return DropdownMenuItem(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDay = value!;
                });
              },
            ),

            const SizedBox(height: 12),

            TextField(
              controller: startTimeController,
              decoration: const InputDecoration(
                labelText: "Start Time",
                hintText: "08:30",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: endTimeController,
              decoration: const InputDecoration(
                labelText: "End Time",
                hintText: "10:30",
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              children: colors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color.value;
                    });
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: color,
                    child: selectedColor == color.value
                        ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    )
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),

      actions: [

        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: save,
          child: Text(
            widget.timetable == null
                ? "Save"
                : "Update",
          ),
        ),
      ],
    );
  }
}