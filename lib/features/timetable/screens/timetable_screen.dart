import 'package:flutter/material.dart';

import '../controllers/timetable_controller.dart';
import '../models/timetable_model.dart';

import '../widgets/day_selector.dart';
import '../widgets/semester_dropdown.dart';
import '../widgets/timetable_card.dart';
import '../widgets/timetable_details_dialog.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() =>
      _TimetableScreenState();
}

class _TimetableScreenState
    extends State<TimetableScreen> {

  final TextEditingController searchController =
  TextEditingController();

  String searchText = "";

  String selectedSemester = "All";

  String selectedDay = "All";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "University Timetable",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(

        children: [

      Padding(

      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        10,
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

        TextField(

        controller: searchController,

        decoration: InputDecoration(

          filled: true,
          fillColor: Theme.of(context).cardColor,

          hintText:
          "Search by subject, lecturer or room",

          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).hintColor,
          ),

          suffixIcon:
          searchText.isNotEmpty

              ? IconButton(

            onPressed: () {

              searchController.clear();

              setState(() {

                searchText = "";

              });

            },

            icon: const Icon(
              Icons.clear,
            ),
          )

              : null,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),

        onChanged: (value) {

          setState(() {

            searchText =
                value.toLowerCase();

          });

        },
      ),

      const SizedBox(height: 18),

          Text(
            "Semester",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),

      const SizedBox(height: 8),

      SemesterDropdown(

        selectedSemester:
        selectedSemester,

        onChanged: (semester) {

          setState(() {

            selectedSemester =
                semester;

          });

        },
      ),

      const SizedBox(height: 18),
          Text(
            "Day",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),

          const SizedBox(height: 8),

          DaySelector(
            selectedDay: selectedDay,
            onDayChanged: (day) {
              setState(() {
                selectedDay = day;
              });
            },
          ),




        ],
      ),
    ),

    Expanded(
    child: StreamBuilder<
    List<TimetableModel>>(
    stream: TimetableController
        .getTimetable(),

    builder:
    (context, snapshot) {

    if (snapshot
        .connectionState ==
    ConnectionState
        .waiting) {
    return const Center(
    child:
    CircularProgressIndicator(),
    );
    }

    if (snapshot.hasError) {
    return Center(
    child: Text(
    snapshot.error
        .toString(),
    ),
    );
    }

    if (!snapshot.hasData) {
    return const SizedBox();
    }

    List<TimetableModel>
    timetable =
    snapshot.data!;
    /// ---------------- SEMESTER FILTER ----------------

    if (selectedSemester != "All") {
    timetable = timetable.where((item) {
    return item.semester ==
    selectedSemester;
    }).toList();
    }

    /// ---------------- DAY FILTER ----------------

    if (selectedDay != "All") {
    timetable = timetable.where((item) {
    return item.day ==
    selectedDay;
    }).toList();
    }

    /// ---------------- SEARCH FILTER ----------------

    if (searchText.isNotEmpty) {
    timetable = timetable.where((item) {
    return item.subject
        .toLowerCase()
        .contains(searchText) ||
    item.lecturer
        .toLowerCase()
        .contains(searchText) ||
    item.room
        .toLowerCase()
        .contains(searchText);
    }).toList();
    }

    /// ---------------- SORT ----------------

    timetable.sort((a, b) {
    return a.startTime.compareTo(
    b.startTime,
    );
    });

    /// ---------------- EMPTY ----------------

    if (timetable.isEmpty) {
    return Center(
    child: Padding(
    padding:
    const EdgeInsets.all(24),
    child: Column(
    mainAxisAlignment:
    MainAxisAlignment
        .center,
    children: [

    Icon(
    Icons
        .calendar_month_outlined,
    size: 90,
      color: Theme.of(context).hintColor,
    ),

    const SizedBox(height: 20),

      Text(
        "No Classes Found",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),

    const SizedBox(height: 8),

    Text(
    "Try changing the semester or day filter.",
    textAlign:
    TextAlign.center,
    style: TextStyle(
      color: Theme.of(context).hintColor,
    ),
    ),
    ],
    ),
    ),
    );
    }

    return RefreshIndicator(

    onRefresh: () async {

    setState(() {});

    },

    child: ListView.builder(

    padding:
    const EdgeInsets.fromLTRB(
    16,
    0,
    16,
    20,
    ),

    itemCount:
    timetable.length,

    itemBuilder:
    (context, index) {

    final item =
    timetable[index];
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 14,
      ),
      child: InkWell(
        borderRadius:
        BorderRadius.circular(
          18,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (_) =>
                TimetableDetailsDialog(
                  timetable: item,
                ),
          );
        },
        child: TimetableCard(
          timetable: item,
        ),
      ),
    );
    },
    ),
    );
    },
    ),
    ),
        ],
      ),
    );
  }
}