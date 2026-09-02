import '../models/assignment_model.dart';
import '../services/assignment_service.dart';

class AssignmentController {
  static Stream<List<AssignmentModel>> getAssignments() {
    return AssignmentService.getAssignments();
  }

  static Future<void> addAssignment(
      AssignmentModel assignment) {
    return AssignmentService.addAssignment(assignment);
  }

  static Future<void> updateAssignment(
      String id,
      AssignmentModel assignment,
      ) {
    return AssignmentService.updateAssignment(
      id,
      assignment,
    );
  }

  static Future<void> deleteAssignment(
      String id) {
    return AssignmentService.deleteAssignment(id);
  }
}