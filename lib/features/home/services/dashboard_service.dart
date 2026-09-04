import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  static final firestore =
      FirebaseFirestore.instance;

  static Stream<int> assignmentCount() {
    return firestore
        .collection("assignments")
        .snapshots()
        .map((e) => e.docs.length);
  }

  static Stream<int> timetableCount() {
    return firestore
        .collection("timetable")
        .snapshots()
        .map((e) => e.docs.length);
  }

  static Stream<int> noticeCount() {
    return firestore
        .collection("notices")
        .snapshots()
        .map((e) => e.docs.length);
  }

  static Stream<int> marketplaceCount() {
    return firestore
        .collection("marketplace")
        .snapshots()
        .map((e) => e.docs.length);
  }

  static Stream<int> lostFoundCount() {
    return firestore
        .collection("lost_found")
        .snapshots()
        .map((e) => e.docs.length);
  }
}