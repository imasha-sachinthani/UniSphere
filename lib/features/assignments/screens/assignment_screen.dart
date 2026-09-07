import 'package:flutter/material.dart';

import '../controllers/assignment_controller.dart';
import '../models/assignment_model.dart';

import '../widgets/assignment_card.dart';
import '../widgets/assignment_details_dialog.dart';
import '../widgets/semester_dropdown.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() =>
      _AssignmentScreenState();
}

class _AssignmentScreenState
    extends State<AssignmentScreen> {

  final TextEditingController searchController =
  TextEditingController();

  String searchText = "";

  String selectedSemester = "All";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Assignments",
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

            controller:
            searchController,

            decoration:
            InputDecoration(

              hintText:
              "Search assignments...",

              prefixIcon:
              const Icon(
                Icons.search,
              ),

              suffixIcon:
              searchText.isNotEmpty

                  ? IconButton(

                onPressed: () {

                  searchController
                      .clear();

                  setState(() {

                    searchText = "";

                  });

                },

                icon: const Icon(
                  Icons.clear,
                ),
              )

                  : null,

              border:
              OutlineInputBorder(

                borderRadius:
                BorderRadius.circular(
                  14,
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

          const SizedBox(
            height: 18,
          ),

          const Text(

            "Semester",

            style: TextStyle(

              fontWeight:
              FontWeight.bold,

              fontSize: 16,

            ),
          ),

          const SizedBox(
            height: 8,
          ),

          SemesterDropdown(

            selectedSemester:
            selectedSemester,

            onChanged:
                (semester) {

              setState(() {

                selectedSemester =
                    semester;

              });

            },
          ),
        ],
      ),
    ),

    Expanded(

    child: StreamBuilder<
    List<AssignmentModel>>(

    stream:
    AssignmentController
        .getAssignments(),

    builder:
    (context, snapshot) {
    if (snapshot.connectionState ==
    ConnectionState.waiting) {
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

    List<AssignmentModel>
    assignments =
    snapshot.data!;

    /// ---------------- SEMESTER FILTER ----------------

    if (selectedSemester !=
    "All") {
    assignments =
    assignments.where(
    (item) {
    return item
        .semester ==
    selectedSemester;
    },
    ).toList();
    }

    /// ---------------- SEARCH ----------------

    if (searchText.isNotEmpty) {
    assignments =
    assignments.where(
    (item) {
    return item.title
        .toLowerCase()
        .contains(
    searchText,
    ) ||
    item.module
        .toLowerCase()
        .contains(
    searchText,
    ) ||
    item.lecturer
        .toLowerCase()
        .contains(
    searchText,
    );
    },
    ).toList();
    }

    /// ---------------- EMPTY ----------------

    if (assignments.isEmpty) {
    return const Center(
    child: Column(
    mainAxisAlignment:
    MainAxisAlignment
        .center,
    children: [

    Icon(
    Icons.assignment,
    size: 90,
    color: Colors.grey,
    ),

    SizedBox(height: 20),

    Text(
    "No Assignments Found",
    style: TextStyle(
    fontSize: 22,
    fontWeight:
    FontWeight.bold,
    ),
    ),

    SizedBox(height: 8),

    Text(
    "Try changing the search or semester filter.",
    textAlign:
    TextAlign.center,
    style: TextStyle(
    color: Colors.grey,
    ),
    ),
    ],
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
    assignments.length,

      itemBuilder: (context, index) {

        final assignment = assignments[index];

        return Padding(
          padding: const EdgeInsets.only(
            bottom: 14,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AssignmentDetailsDialog(
                  assignment: assignment,
                ),
              );
            },
            child: AssignmentCard(
              assignment: assignment,
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