import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/assignment_model.dart';

class AssignmentService {
  static final collection =
  FirebaseFirestore.instance.collection("assignments");

  static Stream<List<AssignmentModel>> getAssignments() {
    return collection.snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => AssignmentModel.fromFirestore(doc))
          .toList(),
    );
  }

  static Future<void> addAssignment(
      AssignmentModel assignment) async {
    await collection.add(assignment.toMap());
  }

  static Future<void> updateAssignment(
      String id,
      AssignmentModel assignment,
      ) async {
    await collection.doc(id).update(assignment.toMap());
  }

  static Future<void> deleteAssignment(
      String id) async {
    await collection.doc(id).delete();
  }
}