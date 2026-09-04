import 'package:flutter/material.dart';

import '../controllers/search_controller.dart';
import '../models/search_item_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {

  final controller = TextEditingController();

  List<SearchItemModel> results = [];

  bool loading = false;

  Future<void> performSearch() async {

    setState(() {
      loading = true;
    });

    results = await GlobalSearchController.search(
      controller.text,
    );

    setState(() {
      loading = false;
    });
  }

  IconData iconFor(String type) {

    switch (type) {

      case "Assignment":
        return Icons.assignment;

      case "Timetable":
        return Icons.calendar_month;

      case "Notice":
        return Icons.campaign;

      case "Marketplace":
        return Icons.shopping_bag;

      case "Lost Item":
        return Icons.search;

      default:
        return Icons.folder;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Search"),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller: controller,

              decoration: InputDecoration(

                hintText:
                "Search...",

                prefixIcon:
                const Icon(Icons.search),

                suffixIcon: IconButton(

                  icon:
                  const Icon(Icons.send),

                  onPressed:
                  performSearch,
                ),

                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                      12),
                ),
              ),

              onSubmitted: (_) {
                performSearch();
              },
            ),

            const SizedBox(height: 20),

            if (loading)
              const CircularProgressIndicator(),

            if (!loading)

              Expanded(

                child: ListView.builder(

                  itemCount:
                  results.length,

                  itemBuilder:
                      (context, index) {

                    final item =
                    results[index];

                    return Card(

                      child: ListTile(

                        leading: Icon(
                          iconFor(
                              item.type),
                        ),

                        title:
                        Text(item.title),

                        subtitle:
                        Text(item.type),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}