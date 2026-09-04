import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/search_item_model.dart';

class SearchService {

  static final firestore =
      FirebaseFirestore.instance;

  static Future<List<SearchItemModel>>
  search(String keyword) async {

    List<SearchItemModel> results = [];

    if (keyword.trim().isEmpty) {
      return results;
    }

    final collections = [

      {
        "name": "assignments",
        "field": "title",
        "type": "Assignment",
      },

      {
        "name": "timetable",
        "field": "subject",
        "type": "Timetable",
      },

      {
        "name": "notices",
        "field": "title",
        "type": "Notice",
      },

      {
        "name": "marketplace",
        "field": "title",
        "type": "Marketplace",
      },

      {
        "name": "lost_found",
        "field": "title",
        "type": "Lost Item",
      },
    ];

    for (final item in collections) {

      final snapshot = await firestore
          .collection(item["name"]!)
          .get();

      for (final doc in snapshot.docs) {

        final value =
        (doc[item["field"]!] ?? "")
            .toString();

        if (value.toLowerCase().contains(
          keyword.toLowerCase(),
        )) {

          results.add(

            SearchItemModel(

              id: doc.id,

              title: value,

              subtitle:
              item["type"]!,

              type:
              item["type"]!,
            ),
          );
        }
      }
    }

    return results;
  }
}