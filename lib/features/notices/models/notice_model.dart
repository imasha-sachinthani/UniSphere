import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final bool pinned;

  NoticeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.pinned,
  });

  factory NoticeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return NoticeModel(
      id: doc.id,
      title: data["title"],
      description: data["description"],
      category: data["category"],
      date: (data["date"] as Timestamp).toDate(),
      pinned: data["pinned"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "category": category,
      "date": date,
      "pinned": pinned,
    };
  }
}