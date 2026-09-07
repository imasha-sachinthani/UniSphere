import '../models/assignment_model.dart';
import '../services/assignment_service.dart';

class AssignmentController {

  static Stream<List<AssignmentModel>>
  getAssignments() {

    return AssignmentService.getAssignments();

  }
}