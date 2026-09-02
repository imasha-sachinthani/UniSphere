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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Lost & Found"),
        centerTitle: true,
      ),

      body: StreamBuilder<List<LostFoundModel>>(

        stream:
        LostFoundController.getItems(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.search,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    "No Lost Items",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Tap + to add an item.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          final items = snapshot.data!;

          return ListView.builder(

            padding:
            const EdgeInsets.all(16),

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

                    builder: (_) => AlertDialog(

                      title:
                      const Text("Delete"),

                      content: const Text(
                        "Delete this item?",
                      ),

                      actions: [

                        TextButton(

                          onPressed: () {
                            Navigator.pop(
                                context,
                                false);
                          },

                          child: const Text(
                            "Cancel",
                          ),
                        ),

                        ElevatedButton(

                          onPressed: () {
                            Navigator.pop(
                                context,
                                true);
                          },

                          child: const Text(
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
          );
        },
      ),

      floatingActionButton:
      FloatingActionButton(

        child: const Icon(Icons.add),

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