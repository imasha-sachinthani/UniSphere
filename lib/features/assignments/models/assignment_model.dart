import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentModel {
  final String id;
  final String title;
  final String module;
  final String description;
  final DateTime deadline;
  final bool completed;
  final int priority;

  AssignmentModel({
    required this.id,
    required this.title,
    required this.module,
    required this.description,
    required this.deadline,
    required this.completed,
    required this.priority,
  });

  factory AssignmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return AssignmentModel(
      id: doc.id,
      title: data["title"],
      module: data["module"],
      description: data["description"],
      deadline: (data["deadline"] as Timestamp).toDate(),
      completed: data["completed"],
      priority: data["priority"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "module": module,
      "description": description,
      "deadline": deadline,
      "completed": completed,
      "priority": priority,
    };
  }
}