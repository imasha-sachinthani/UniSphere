import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/timetable_model.dart';

class TimetableService {
  static final CollectionReference collection =
  FirebaseFirestore.instance.collection("timetable");

  static Stream<List<TimetableModel>> getTimetable() {
    return collection.snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => TimetableModel.fromFirestore(doc))
          .toList(),
    );
  }
}