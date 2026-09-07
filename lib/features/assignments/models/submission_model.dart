import 'package:cloud_firestore/cloud_firestore.dart';

class SubmissionModel {
  final String id;

  final String assignmentId;

  final String studentUid;

  final String studentName;

  final String studentEmail;

  final String fileName;

  final String fileUrl;

  final DateTime submittedAt;

  final String status;

  const SubmissionModel({
    required this.id,
    required this.assignmentId,
    required this.studentUid,
    required this.studentName,
    required this.studentEmail,
    required this.fileName,
    required this.fileUrl,
    required this.submittedAt,
    required this.status,
  });

  factory SubmissionModel.fromFirestore(
      DocumentSnapshot doc) {
    final data =
    doc.data() as Map<String, dynamic>;

    return SubmissionModel(
      id: doc.id,

      assignmentId:
      data["assignmentId"] ?? "",

      studentUid:
      data["studentUid"] ?? "",

      studentName:
      data["studentName"] ?? "",

      studentEmail:
      data["studentEmail"] ?? "",

      fileName:
      data["fileName"] ?? "",

      fileUrl:
      data["fileUrl"] ?? "",

      submittedAt:
      (data["submittedAt"]
      as Timestamp?)
          ?.toDate() ??
          DateTime.now(),

      status:
      data["status"] ?? "Submitted",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "assignmentId": assignmentId,
      "studentUid": studentUid,
      "studentName": studentName,
      "studentEmail": studentEmail,
      "fileName": fileName,
      "fileUrl": fileUrl,
      "submittedAt": submittedAt,
      "status": status,
    };
  }
}