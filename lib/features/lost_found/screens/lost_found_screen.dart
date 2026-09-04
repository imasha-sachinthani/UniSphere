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
  final TextEditingController searchController =
  TextEditingController();

  String searchText = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lost & Found"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                16, 16, 16, 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search lost items...",
                prefixIcon:
                const Icon(Icons.search),
                suffixIcon:
                searchText.isNotEmpty
                    ? IconButton(
                  icon: const Icon(
                      Icons.clear),
                  onPressed: () {
                    searchController
                        .clear();

                    setState(() {
                      searchText = "";
                    });
                  },
                )
                    : null,
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                      12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText =
                      value.toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child:
            StreamBuilder<List<LostFoundModel>>(
              stream:
              LostFoundController.getItems(),

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

                List<LostFoundModel> items =
                snapshot.data!;

                if (searchText
                    .isNotEmpty) {
                  items = items
                      .where((item) {
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
                            searchText);
                  }).toList();
                }

                if (items.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "No Lost Items Found",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight:
                            FontWeight
                                .bold,
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
                  child:
                  ListView.builder(
                    padding:
                    const EdgeInsets
                        .all(16),
                    itemCount:
                    items.length,
                    itemBuilder:
                        (context,
                        index) {
                      final item =
                      items[index];

                      return LostItemCard(
                        item: item,

                        onEdit: () {
                          showDialog(
                            context:
                            context,
                            builder:
                                (_) =>
                                AddLostItemDialog(
                                  item: item,
                                ),
                          );
                        },

                        onDelete:
                            () async {
                          final confirm =
                          await showDialog<
                              bool>(
                            context:
                            context,
                            builder:
                                (_) =>
                                AlertDialog(
                                  title:
                                  const Text(
                                      "Delete Item"),
                                  content:
                                  const Text(
                                      "Are you sure you want to delete this item?"),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () {
                                        Navigator.pop(
                                            context,
                                            false);
                                      },
                                      child:
                                      const Text(
                                          "Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed:
                                          () {
                                        Navigator.pop(
                                            context,
                                            true);
                                      },
                                      child:
                                      const Text(
                                          "Delete"),
                                    ),
                                  ],
                                ),
                          );

                          if (confirm ==
                              true) {
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

      floatingActionButton:
      FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Add"),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) =>
            const AddLostItemDialog(),
          );
        },
      ),
    );
  }
}