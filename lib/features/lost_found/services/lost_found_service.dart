import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/lost_found_model.dart';

class LostFoundService {
  static final collection =
  FirebaseFirestore.instance.collection(
    "lost_found",
  );

  /// ==============================
  /// GET ALL ITEMS
  /// ==============================

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
            LostFoundModel.fromFirestore(
              doc,
            ),
      )
          .toList(),
    );
  }

  /// ==============================
  /// GET USER ITEMS
  /// ==============================

  static Stream<List<LostFoundModel>>
  getUserItems(String uid) {
    return collection
        .where("uid", isEqualTo: uid)
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) =>
            LostFoundModel.fromFirestore(
              doc,
            ),
      )
          .toList(),
    );
  }

  /// ==============================
  /// ADD ITEM
  /// ==============================

  static Future<void> addItem(
      LostFoundModel item,
      ) async {
    await collection.add(item.toMap());
  }

  /// ==============================
  /// UPDATE ITEM
  /// ==============================

  static Future<void> updateItem(
      String id,
      LostFoundModel item,
      ) async {
    await collection
        .doc(id)
        .update(item.toMap());
  }

  /// ==============================
  /// DELETE ITEM
  /// ==============================

  static Future<void> deleteItem(
      String id,
      ) async {
    await collection.doc(id).delete();
  }

  /// ==============================
  /// MARK AS CLAIMED
  /// ==============================

  static Future<void> markAsClaimed(
      String id,
      ) async {
    await collection.doc(id).update({
      "claimed": true,
    });
  }

  /// ==============================
  /// MARK AS AVAILABLE
  /// ==============================

  static Future<void> markAsAvailable(
      String id,
      ) async {
    await collection.doc(id).update({
      "claimed": false,
    });
  }
}