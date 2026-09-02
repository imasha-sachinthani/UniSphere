import 'package:flutter/material.dart';

import '../controllers/timetable_controller.dart';
import '../models/timetable_model.dart';
import '../widgets/timetable_card.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  List<TimetableModel> timetableList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTimetable();
  }

  Future<void> loadTimetable() async {
    setState(() {
      isLoading = true;
    });

    timetableList = await TimetableController.getTimetable();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timetable"),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: loadTimetable,

        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : timetableList.isEmpty
            ? ListView(
          children: const [
            SizedBox(height: 180),

            Icon(
              Icons.calendar_month,
              size: 90,
              color: Colors.grey,
            ),

            SizedBox(height: 20),

            Center(
              child: Text(
                "No Timetable Available",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 8),

            Center(
              child: Text(
                "Your timetable will appear here.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        )
            : ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: timetableList.length,
          itemBuilder: (context, index) {
            return TimetableCard(
              timetable: timetableList[index],
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},

        child: const Icon(Icons.add),
      ),
    );
  }
}