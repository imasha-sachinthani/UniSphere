import 'package:cloud_firestore/cloud_firestore.dart';

class TimetableModel {
  final String id;
  final String subject;
  final String lecturer;
  final String room;
  final String day;
  final String startTime;
  final String endTime;
  final int color;

  TimetableModel({
    required this.id,
    required this.subject,
    required this.lecturer,
    required this.room,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.color,
  });

  factory TimetableModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return TimetableModel(
      id: doc.id,
      subject: data['subject'],
      lecturer: data['lecturer'],
      room: data['room'],
      day: data['day'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      color: data['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'lecturer': lecturer,
      'room': room,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
    };
  }
}