import 'package:cloud_firestore/cloud_firestore.dart';

class LostFoundModel {
  final String id;

  /// Owner
  final String uid;
  final String userName;
  final String email;
  final String phone;

  /// Item
  final String title;
  final String description;
  final String category;
  final String status; // Lost | Found
  final String location;
  final String imageUrl;

  /// State
  final bool claimed;

  final DateTime createdAt;

  const LostFoundModel({
    required this.id,
    required this.uid,
    required this.userName,
    required this.email,
    required this.phone,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.location,
    required this.imageUrl,
    required this.claimed,
    required this.createdAt,
  });

  factory LostFoundModel.fromFirestore(
      DocumentSnapshot doc,
      ) {
    final data =
    doc.data() as Map<String, dynamic>;

    return LostFoundModel(
      id: doc.id,

      uid: data["uid"] ?? "",

      userName: data["userName"] ?? "",

      email: data["email"] ?? "",

      phone: data["phone"] ?? "",

      title: data["title"] ?? "",

      description:
      data["description"] ?? "",

      category:
      data["category"] ?? "Other",

      status:
      data["status"] ?? "Lost",

      location:
      data["location"] ?? "",

      imageUrl:
      data["imageUrl"] ?? "",

      claimed:
      data["claimed"] ?? false,

      createdAt:
      (data["createdAt"] as Timestamp)
          .toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "userName": userName,
      "email": email,
      "phone": phone,
      "title": title,
      "description": description,
      "category": category,
      "status": status,
      "location": location,
      "imageUrl": imageUrl,
      "claimed": claimed,
      "createdAt": createdAt,
    };
  }
}