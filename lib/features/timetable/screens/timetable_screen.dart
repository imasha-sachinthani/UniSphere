import 'package:flutter/material.dart';

import '../controllers/timetable_controller.dart';
import '../models/timetable_model.dart';
import '../widgets/add_timetable_dialog.dart';
import '../widgets/timetable_card.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timetable"),
        centerTitle: true,
      ),

      body: StreamBuilder<List<TimetableModel>>(
        stream: TimetableController.getTimetable(),
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

          final timetableList = snapshot.data ?? [];

          if (timetableList.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 90,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "No Timetable Yet",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Tap + to add your first class.",
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
            itemCount: timetableList.length,
            itemBuilder: (context, index) {
              final timetable = timetableList[index];

              return TimetableCard(
                timetable: timetable,

                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddTimetableDialog(
                      timetable: timetable,
                    ),
                  );
                },

                onDelete: () async {
                  final delete = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Delete"),
                      content: const Text(
                        "Delete this timetable entry?",
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
                    await TimetableController.deleteTimetable(
                      timetable.id,
                    );
                  }
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
            builder: (_) => const AddTimetableDialog(),
          );
        },
      ),
    );
  }
}