import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentModel {
  final String id;

  final String title;
  final String module;
  final String lecturer;
  final String semester;
  final String description;

  final DateTime deadline;

  final int priority;
  final bool completed;

  final String attachmentUrl;

  final DateTime createdAt;

  const AssignmentModel({
    required this.id,
    required this.title,
    required this.module,
    required this.lecturer,
    required this.semester,
    required this.description,
    required this.deadline,
    required this.priority,
    required this.completed,
    required this.attachmentUrl,
    required this.createdAt,
  });

  factory AssignmentModel.fromFirestore(
      DocumentSnapshot doc) {
    final data =
    doc.data() as Map<String, dynamic>;

    return AssignmentModel(
      id: doc.id,

      title: data["title"] ?? "",

      module: data["module"] ?? "",

      lecturer: data["lecturer"] ?? "",

      semester: data["semester"] ?? "",

      description:
      data["description"] ?? "",

      deadline:
      (data["deadline"] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),

      priority:
      data["priority"] ?? 2,

      completed:
      data["completed"] ?? false,

      attachmentUrl:
      data["attachmentUrl"] ?? "",

      createdAt:
      (data["createdAt"] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,

      "module": module,

      "lecturer": lecturer,

      "semester": semester,

      "description": description,

      "deadline": deadline,

      "priority": priority,

      "completed": completed,

      "attachmentUrl": attachmentUrl,

      "createdAt": createdAt,
    };
  }

  AssignmentModel copyWith({
    String? id,
    String? title,
    String? module,
    String? lecturer,
    String? semester,
    String? description,
    DateTime? deadline,
    int? priority,
    bool? completed,
    String? attachmentUrl,
    DateTime? createdAt,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      module: module ?? this.module,
      lecturer: lecturer ?? this.lecturer,
      semester: semester ?? this.semester,
      description:
      description ?? this.description,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
      completed:
      completed ?? this.completed,
      attachmentUrl:
      attachmentUrl ??
          this.attachmentUrl,
      createdAt:
      createdAt ?? this.createdAt,
    );
  }
}