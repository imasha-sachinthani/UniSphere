import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class MarketplaceService {

  static final collection =
  FirebaseFirestore.instance.collection(
    "marketplace",
  );

  static Stream<List<ProductModel>>
  getProducts() {

    return collection
        .orderBy(
      "createdAt",
      descending: true,
    )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => ProductModel.fromFirestore(doc),
      )
          .toList(),
    );
  }

  static Future<void> addProduct(
      ProductModel product) async {

    await collection.add(
      product.toMap(),
    );
  }

  static Future<void> updateProduct(
      String id,
      ProductModel product) async {

    await collection.doc(id).update(
      product.toMap(),
    );
  }

  static Future<void> deleteProduct(
      String id) async {

    await collection.doc(id).delete();
  }
}