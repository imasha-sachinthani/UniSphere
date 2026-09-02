import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/timetable_model.dart';

class TimetableService {
  static final collection =
  FirebaseFirestore.instance.collection("timetable");

  static Stream<List<TimetableModel>> getClasses() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => TimetableModel.fromFirestore(doc))
          .toList();
    });
  }

  static Future<void> addClass(TimetableModel model) async {
    await collection.add(model.toMap());
  }

  static Future<void> deleteClass(String id) async {
    await collection.doc(id).delete();
  }

  static Future<void> updateClass(
      String id,
      TimetableModel model,
      ) async {
    await collection.doc(id).update(model.toMap());
  }
}