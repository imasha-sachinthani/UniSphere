import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/submission_model.dart';
import 'assignment_file_service.dart';

class SubmissionService {
  static final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth auth =
      FirebaseAuth.instance;

  static final CollectionReference submissions =
  firestore.collection("submissions");

  /// Upload Assignment Submission
  static Future<void> uploadSubmission({
    required String assignmentId,
    required String studentName,
    required File file,
  }) async {
    final user = auth.currentUser!;

    final uploadedFile =
    await AssignmentFileService.uploadFile(file);

    if (uploadedFile == null) {
      throw Exception("File upload failed.");
    }

    final submission = SubmissionModel(
      id: "",
      assignmentId: assignmentId,
      studentUid: user.uid,
      studentName: studentName,
      studentEmail: user.email ?? "",

      fileName: uploadedFile["name"]!,
      fileUrl: uploadedFile["url"]!,

      submittedAt: DateTime.now(),
      status: "Submitted",
    );

    await submissions.add(
      submission.toMap(),
    );
  }

  /// Current Student Submission
  static Stream<SubmissionModel?> getSubmission(
      String assignmentId) {
    final user = auth.currentUser!;

    return submissions
        .where(
      "assignmentId",
      isEqualTo: assignmentId,
    )
        .where(
      "studentUid",
      isEqualTo: user.uid,
    )
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      }

      return SubmissionModel.fromFirestore(
        snapshot.docs.first,
      );
    });
  }

  /// Delete Submission
  static Future<void> deleteSubmission(
      SubmissionModel submission) async {
    await submissions
        .doc(submission.id)
        .delete();
  }
}