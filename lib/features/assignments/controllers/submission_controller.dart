import 'dart:io';

import '../models/submission_model.dart';
import '../services/submission_service.dart';

class SubmissionController {

  /// Upload Assignment Submission
  static Future<void> uploadSubmission({
    required String assignmentId,
    required String studentName,
    required File file,
  }) {
    return SubmissionService.uploadSubmission(
      assignmentId: assignmentId,
      studentName: studentName,
      file: file,
    );
  }

  /// Current Student Submission
  static Stream<SubmissionModel?> getSubmission(
      String assignmentId,
      ) {
    return SubmissionService.getSubmission(
      assignmentId,
    );
  }

  /// Delete Submission
  static Future<void> deleteSubmission(
      SubmissionModel submission,
      ) {
    return SubmissionService.deleteSubmission(
      submission,
    );
  }
}