import 'package:cloud_firestore/cloud_firestore.dart';

class LostFoundModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;
  final bool claimed;
  final DateTime createdAt;

  LostFoundModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.claimed,
    required this.createdAt,
  });

  factory LostFoundModel.fromFirestore(
      DocumentSnapshot doc) {
    final data =
    doc.data() as Map<String, dynamic>;

    return LostFoundModel(
      id: doc.id,
      title: data["title"],
      description: data["description"],
      location: data["location"],
      imageUrl: data["imageUrl"],
      claimed: data["claimed"],
      createdAt:
      (data["createdAt"] as Timestamp)
          .toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "location": location,
      "imageUrl": imageUrl,
      "claimed": claimed,
      "createdAt": createdAt,
    };
  }
}