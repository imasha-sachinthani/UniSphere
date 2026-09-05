import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  final String id;

  /// Notice
  final String title;
  final String description;

  /// Category
  final String category;

  /// Department
  final String department;

  /// Priority
  final String priority;

  /// Publisher
  final String publishedBy;

  /// Attachment
  final String attachmentUrl;

  /// Pin Notice
  final bool pinned;

  /// Created Time
  final DateTime createdAt;

  const NoticeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.department,
    required this.priority,
    required this.publishedBy,
    required this.attachmentUrl,
    required this.pinned,
    required this.createdAt,
  });

  factory NoticeModel.fromFirestore(
      DocumentSnapshot doc,
      ) {
    final data =
    doc.data() as Map<String, dynamic>;

    return NoticeModel(
      id: doc.id,

      title:
      data["title"] ?? "",

      description:
      data["description"] ?? "",

      category:
      data["category"] ?? "General",

      department:
      data["department"] ??
          "University",

      priority:
      data["priority"] ??
          "Normal",

      publishedBy:
      data["publishedBy"] ??
          "Administration",

      attachmentUrl:
      data["attachmentUrl"] ??
          "",

      pinned:
      data["pinned"] ??
          false,

      createdAt:
      (data["createdAt"]
      as Timestamp)
          .toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {

      "title": title,

      "description":
      description,

      "category":
      category,

      "department":
      department,

      "priority":
      priority,

      "publishedBy":
      publishedBy,

      "attachmentUrl":
      attachmentUrl,

      "pinned":
      pinned,

      "createdAt":
      createdAt,
    };
  }
}