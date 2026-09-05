import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class MarketplaceService {
  MarketplaceService._();

  static final CollectionReference<Map<String, dynamic>>
  collection = FirebaseFirestore.instance.collection(
    "marketplace",
  );

  /// ---------------- GET ALL PRODUCTS ----------------

  static Stream<List<ProductModel>> getProducts() {
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
            ProductModel.fromFirestore(doc),
      )
          .toList(),
    );
  }

  /// ---------------- ADD PRODUCT ----------------

  static Future<void> addProduct(
      ProductModel product,
      ) async {
    await collection.add(
      product.toMap(),
    );
  }

  /// ---------------- UPDATE PRODUCT ----------------

  static Future<void> updateProduct(
      String id,
      ProductModel product,
      ) async {
    await collection
        .doc(id)
        .update(
      product.toMap(),
    );
  }

  /// ---------------- DELETE PRODUCT ----------------

  static Future<void> deleteProduct(
      String id,
      ) async {
    await collection.doc(id).delete();
  }

  /// ---------------- MARK AS SOLD ----------------

  static Future<void> markAsSold(
      String id,
      bool sold,
      ) async {
    await collection.doc(id).update({
      "isSold": sold,
    });
  }

  /// ---------------- TOGGLE FAVORITE ----------------

  static Future<void> toggleFavorite({
    required String productId,
    required String userId,
    required bool isFavorite,
  }) async {
    final favoriteDoc = collection
        .doc(productId)
        .collection("favorites")
        .doc(userId);

    if (isFavorite) {
      await favoriteDoc.set({
        "createdAt":
        FieldValue.serverTimestamp(),
      });
    } else {
      await favoriteDoc.delete();
    }
  }

  /// ---------------- CHECK FAVORITE ----------------

  static Stream<bool> isFavorite({
    required String productId,
    required String userId,
  }) {
    return collection
        .doc(productId)
        .collection("favorites")
        .doc(userId)
        .snapshots()
        .map(
          (doc) => doc.exists,
    );
  }
}