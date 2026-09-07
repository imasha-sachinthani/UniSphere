import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/submission_model.dart';

class SubmissionService {

  static final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  static final FirebaseStorage storage =
      FirebaseStorage.instance;

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

    final fileName =
        "${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}";

    final Reference ref = storage
        .ref()
        .child("submissions")
        .child(user.uid)
        .child(fileName);

    await ref.putFile(file);

    final fileUrl =
    await ref.getDownloadURL();

    final submission = SubmissionModel(
      id: "",
      assignmentId: assignmentId,
      studentUid: user.uid,
      studentName: studentName,
      studentEmail: user.email ?? "",
      fileName: fileName,
      fileUrl: fileUrl,
      submittedAt: DateTime.now(),
      status: "Submitted",
    );

    await submissions.add(
      submission.toMap(),
    );
  }

  /// Check Current Student Submission
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

    if (submission.fileUrl.isNotEmpty) {
      await storage
          .refFromURL(submission.fileUrl)
          .delete();
    }

    await submissions
        .doc(submission.id)
        .delete();
  }
}