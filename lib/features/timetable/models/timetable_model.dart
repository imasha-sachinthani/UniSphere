import 'package:cloud_firestore/cloud_firestore.dart';

class TimetableModel {
  final String id;
  final String subject;
  final String lecturer;
  final String room;
  final String day;
  final String semester;
  final String startTime;
  final String endTime;
  final int color;
  final DateTime createdAt;

  const TimetableModel({
    required this.id,
    required this.subject,
    required this.lecturer,
    required this.room,
    required this.day,
    required this.semester,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.createdAt,
  });

  factory TimetableModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return TimetableModel(
      id: doc.id,
      subject: data["subject"] ?? "",
      lecturer: data["lecturer"] ?? "",
      room: data["room"] ?? "",
      day: data["day"] ?? "",
      semester: data["semester"] ?? "",
      startTime: data["startTime"] ?? "",
      endTime: data["endTime"] ?? "",

      // Null-safe color
      color: (data["color"] as num?)?.toInt() ?? 0xFF2196F3,

      // Null-safe createdAt
      createdAt: data["createdAt"] != null
          ? (data["createdAt"] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "subject": subject,
      "lecturer": lecturer,
      "room": room,
      "day": day,
      "semester": semester,
      "startTime": startTime,
      "endTime": endTime,
      "color": color,

      // Firestore Timestamp
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }
}