import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/lost_found_model.dart';

class LostFoundService {
  static final collection =
  FirebaseFirestore.instance.collection(
    "lost_found",
  );

  static Stream<List<LostFoundModel>>
  getItems() {
    return collection
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) =>
            LostFoundModel.fromFirestore(doc),
      )
          .toList(),
    );
  }

  static Future<void> addItem(
      LostFoundModel item) async {
    await collection.add(item.toMap());
  }

  static Future<void> updateItem(
      String id,
      LostFoundModel item) async {
    await collection.doc(id).update(item.toMap());
  }

  static Future<void> deleteItem(
      String id) async {
    await collection.doc(id).delete();
  }
}