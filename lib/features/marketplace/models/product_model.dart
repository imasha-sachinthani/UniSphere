import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String seller;
  final String imageUrl;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.seller,
    required this.imageUrl,
    required this.createdAt,
  });

  factory ProductModel.fromFirestore(
      DocumentSnapshot doc,
      ) {
    final data =
    doc.data() as Map<String, dynamic>;

    return ProductModel(
      id: doc.id,
      title: data["title"],
      description: data["description"],
      price: (data["price"] as num).toDouble(),
      seller: data["seller"],
      imageUrl: data["imageUrl"],
      createdAt:
      (data["createdAt"] as Timestamp)
          .toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "seller": seller,
      "imageUrl": imageUrl,
      "createdAt": createdAt,
    };
  }
}