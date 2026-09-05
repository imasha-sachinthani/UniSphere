import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;

  final String uid;

  final String title;

  final String description;

  final double price;

  final String sellerName;

  final String sellerEmail;

  final String phone;

  final String category;

  final String condition;

  final String imageUrl;

  final bool isSold;

  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.description,
    required this.price,
    required this.sellerName,
    required this.sellerEmail,
    required this.phone,
    required this.category,
    required this.condition,
    required this.imageUrl,
    required this.isSold,
    required this.createdAt,
  });

  factory ProductModel.fromFirestore(
      DocumentSnapshot doc,
      ) {
    final data =
    doc.data() as Map<String, dynamic>;

    return ProductModel(
      id: doc.id,

      uid: data["uid"] ?? "",

      title: data["title"] ?? "",

      description:
      data["description"] ?? "",

      price:
      (data["price"] as num?)
          ?.toDouble() ??
          0,

      sellerName:
      data["sellerName"] ?? "",

      sellerEmail:
      data["sellerEmail"] ?? "",

      phone: data["phone"] ?? "",

      category:
      data["category"] ?? "Others",

      condition:
      data["condition"] ?? "Used",

      imageUrl:
      data["imageUrl"] ?? "",

      isSold:
      data["isSold"] ?? false,

      createdAt:
      (data["createdAt"]
      as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,

      "title": title,

      "description": description,

      "price": price,

      "sellerName": sellerName,

      "sellerEmail": sellerEmail,

      "phone": phone,

      "category": category,

      "condition": condition,

      "imageUrl": imageUrl,

      "isSold": isSold,

      "createdAt": createdAt,
    };
  }

  ProductModel copyWith({
    String? id,
    String? uid,
    String? title,
    String? description,
    double? price,
    String? sellerName,
    String? sellerEmail,
    String? phone,
    String? category,
    String? condition,
    String? imageUrl,
    bool? isSold,
    DateTime? createdAt,
  }) {
    return ProductModel(
      id: id ?? this.id,

      uid: uid ?? this.uid,

      title: title ?? this.title,

      description:
      description ?? this.description,

      price: price ?? this.price,

      sellerName:
      sellerName ?? this.sellerName,

      sellerEmail:
      sellerEmail ??
          this.sellerEmail,

      phone: phone ?? this.phone,

      category:
      category ?? this.category,

      condition:
      condition ?? this.condition,

      imageUrl:
      imageUrl ?? this.imageUrl,

      isSold:
      isSold ?? this.isSold,

      createdAt:
      createdAt ?? this.createdAt,
    );
  }
}