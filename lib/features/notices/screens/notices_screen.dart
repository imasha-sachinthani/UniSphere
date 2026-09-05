import 'package:flutter/material.dart';

import '../controllers/notice_controller.dart';
import '../models/notice_model.dart';
import '../widgets/notice_card.dart';

class NoticesScreen extends StatefulWidget {
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() =>
      _NoticesScreenState();
}

class _NoticesScreenState
    extends State<NoticesScreen> {

  final TextEditingController
  searchController =
  TextEditingController();

  String searchText = "";

  String selectedCategory = "All";

  final List<String> categories = [

    "All",

    "Exam",

    "Assignment",

    "Academic",

    "Event",

    "Holiday",

    "Career",

    "Emergency",
  ];

  @override
  void dispose() {

    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "University Notices",
        ),

        centerTitle: true,
      ),

      body: Column(

          children: [

      Padding(

      padding:
      const EdgeInsets.all(16),

      child: Column(

        children: [

        TextField(

        controller:
        searchController,

        decoration:
        InputDecoration(

          hintText:
          "Search notices...",

          prefixIcon:
          const Icon(
            Icons.search,
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

      const SizedBox(height: 16),                /// ---------------- CATEGORY FILTER ----------------

          SizedBox(
            height: 42,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,

              itemCount: categories.length,

              itemBuilder: (context, index) {

                final category =
                categories[index];

                return Padding(
                  padding:
                  const EdgeInsets.only(
                    right: 10,
                  ),

                  child: ChoiceChip(

                    label: Text(category),

                    selected:
                    selectedCategory ==
                        category,

                    onSelected: (_) {

                      setState(() {

                        selectedCategory =
                            category;

                      });

                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),

    Expanded(

    child: StreamBuilder<
    List<NoticeModel>>(

    stream:
    NoticeController
        .getNotices(),

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

    List<NoticeModel> notices =
    snapshot.data!;

    /// ---------------- CATEGORY FILTER ----------------

    if (selectedCategory !=
    "All") {

    notices = notices.where(
    (notice) {

    return notice.category ==
    selectedCategory;

    },
    ).toList();
    }

    /// ---------------- SEARCH ----------------

    if (searchText.isNotEmpty) {

    notices = notices.where(
    (notice) {

    return notice.title
        .toLowerCase()
        .contains(
    searchText) ||

    notice.description
        .toLowerCase()
        .contains(
    searchText) ||

    notice.department
        .toLowerCase()
        .contains(
    searchText) ||

    notice.category
        .toLowerCase()
        .contains(
    searchText) ||

    notice.publishedBy
        .toLowerCase()
        .contains(
    searchText);

    },
    ).toList();
    }

    /// ---------------- EMPTY STATE ----------------

    if (notices.isEmpty) {

    return Center(

    child: Column(

    mainAxisAlignment:
    MainAxisAlignment
        .center,

    children: [

    Icon(
    Icons.campaign_outlined,
    size: 90,
    color: Colors
        .grey
        .shade400,
    ),

    const SizedBox(
    height: 20,
    ),

    const Text(
    "No Notices Found",
    style: TextStyle(
    fontSize: 22,
    fontWeight:
    FontWeight.bold,
    ),
    ),

    const SizedBox(
    height: 8,
    ),

    Text(
    "There are no notices matching your search.",
    textAlign:
    TextAlign.center,
    style: TextStyle(
    color: Colors
        .grey
        .shade600,
    ),
    ),
    ],
    ),
    );
    }                return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },

      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          20,
        ),

        itemCount: notices.length,

        itemBuilder: (context, index) {

          final notice =
          notices[index];

          return NoticeCard(
            notice: notice,
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