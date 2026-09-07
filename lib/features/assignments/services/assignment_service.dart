import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/assignment_model.dart';

class AssignmentService {

  static final CollectionReference collection =
  FirebaseFirestore.instance.collection(
    "assignments",
  );

  static Stream<List<AssignmentModel>>
  getAssignments() {

    return collection

        .orderBy(
      "deadline",
      descending: false,
    )

        .snapshots()

        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => AssignmentModel.fromFirestore(doc),
      )
          .toList(),
    );
  }
}