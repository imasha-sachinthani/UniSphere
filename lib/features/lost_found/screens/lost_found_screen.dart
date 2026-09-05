import 'package:flutter/material.dart';

import '../controllers/lost_found_controller.dart';
import '../models/lost_found_model.dart';
import '../widgets/add_lost_item_dialog.dart';
import '../widgets/lost_item_card.dart';

class LostFoundScreen extends StatefulWidget {
  const LostFoundScreen({super.key});

  @override
  State<LostFoundScreen> createState() =>
      _LostFoundScreenState();
}

class _LostFoundScreenState
    extends State<LostFoundScreen> {

  final TextEditingController
  searchController =
  TextEditingController();

  String searchText = "";

  String selectedCategory = "All";

  String selectedStatus = "All";

  final List<String> categories = [

    "All",

    "Phone",

    "Laptop",

    "Student ID",

    "Keys",

    "Bag",

    "Wallet",

    "Books",

    "Calculator",

    "Accessories",

    "Other",
  ];

  final List<String> statusList = [

    "All",

    "Lost",

    "Found",
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
          "Lost & Found",
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
          "Search items...",

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

                searchText =
                "";

              });
            },

            icon:
            const Icon(
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

      const SizedBox(height: 16),                /// ---------- CATEGORY FILTER ----------

          SizedBox(
            height: 42,

            child: ListView.builder(
              scrollDirection:
              Axis.horizontal,

              itemCount:
              categories.length,

              itemBuilder:
                  (context, index) {

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

          const SizedBox(height: 14),

          /// ---------- LOST / FOUND FILTER ----------

          SizedBox(
            height: 42,

            child: ListView.builder(
              scrollDirection:
              Axis.horizontal,

              itemCount:
              statusList.length,

              itemBuilder:
                  (context, index) {

                final status =
                statusList[index];

                return Padding(
                  padding:
                  const EdgeInsets.only(
                    right: 10,
                  ),

                  child: ChoiceChip(

                    label: Text(status),

                    selected:
                    selectedStatus ==
                        status,

                    onSelected: (_) {

                      setState(() {

                        selectedStatus =
                            status;

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
    List<LostFoundModel>>(

    stream:
    LostFoundController
        .getItems(),

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

    List<LostFoundModel>
    items =
    snapshot.data!;

    /// ---------- CATEGORY FILTER ----------

    if (selectedCategory !=
    "All") {

    items = items.where(
    (item) {

    return item.category ==
    selectedCategory;

    },
    ).toList();
    }

    /// ---------- STATUS FILTER ----------

    if (selectedStatus !=
    "All") {

    items = items.where(
    (item) {

    return item.status ==
    selectedStatus;

    },
    ).toList();
    }

    /// ---------- SEARCH ----------

    if (searchText.isNotEmpty) {

    items = items.where(
    (item) {

    return item.title
        .toLowerCase()
        .contains(
    searchText) ||

    item.description
        .toLowerCase()
        .contains(
    searchText) ||

    item.location
        .toLowerCase()
        .contains(
    searchText) ||

    item.category
        .toLowerCase()
        .contains(
    searchText) ||

    item.userName
        .toLowerCase()
        .contains(
    searchText);

    },
    ).toList();
    }

    /// ---------- EMPTY STATE ----------

    if (items.isEmpty) {

    return Center(

    child: Column(

    mainAxisAlignment:
    MainAxisAlignment
        .center,

    children: [

    Icon(
    Icons.search_off,
    size: 90,
    color: Colors
        .grey
        .shade400,
    ),

    const SizedBox(
    height: 20,
    ),

    const Text(
    "No Items Found",

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
    "Report a lost or found item to help other students.",

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
          100,
        ),

        itemCount: items.length,

        itemBuilder: (context, index) {

          final item = items[index];

          return LostItemCard(

            item: item,

            onEdit: () {

              showDialog(
                context: context,

                builder: (_) =>
                    AddLostItemDialog(
                      item: item,
                    ),
              );
            },

            onDelete: () async {

              final confirm =
              await showDialog<bool>(

                context: context,

                builder: (_) =>
                    AlertDialog(

                      title: const Text(
                        "Delete Item",
                      ),

                      content: const Text(
                        "Are you sure you want to delete this item?",
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {

                            Navigator.pop(
                              context,
                              false,
                            );

                          },

                          child:
                          const Text(
                            "Cancel",
                          ),
                        ),

                        ElevatedButton(

                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.red,

                            foregroundColor:
                            Colors.white,
                          ),

                          onPressed: () {

                            Navigator.pop(
                              context,
                              true,
                            );

                          },

                          child:
                          const Text(
                            "Delete",
                          ),
                        ),
                      ],
                    ),
              );

              if (confirm == true) {

                await LostFoundController
                    .deleteItem(
                  item.id,
                );
              }
            },
          );
        },
      ),
    );
    },
    ),
    ),
          ],
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation
          .endFloat,

      floatingActionButton:
      FloatingActionButton(

        heroTag: "lostFoundFab",

        tooltip: "Report Item",

        elevation: 5,

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

        onPressed: () {

          showDialog(

            context: context,

            builder: (_) =>
            const AddLostItemDialog(),
          );
        },

        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}