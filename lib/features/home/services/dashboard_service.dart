import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// ==============================
  /// Upcoming Assignment
  /// ==============================

  static Stream<QueryDocumentSnapshot?> getUpcomingAssignment() {
    return _firestore
        .collection("assignments")
        .where("completed", isEqualTo: false)
        .orderBy("deadline")
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      }

      return snapshot.docs.first;
    });
  }

  /// ==============================
  /// Next Class
  /// ==============================

  static Stream<QueryDocumentSnapshot?> getNextClass() {
    final today = _todayName();

    return _firestore
        .collection("timetable")
        .where("day", isEqualTo: today)
        .orderBy("startTime")
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      }

      return snapshot.docs.first;
    });
  }

  /// ==============================
  /// Latest Notice
  /// ==============================

  static Stream<QueryDocumentSnapshot?> getLatestNotice() {
    return _firestore
        .collection("notices")
        .orderBy("createdAt", descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      }

      return snapshot.docs.first;
    });
  }

  /// ==============================
  /// Latest Marketplace Item
  /// ==============================

  static Stream<QueryDocumentSnapshot?> getLatestMarketplace() {
    return _firestore
        .collection("marketplace")
        .where("isSold", isEqualTo: false)
        .orderBy("createdAt", descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      }

      return snapshot.docs.first;
    });
  }

  /// ==============================
  /// Latest Lost & Found
  /// ==============================

  static Stream<QueryDocumentSnapshot?> getLatestLostFound() {
    return _firestore
        .collection("lost_found")
        .where("claimed", isEqualTo: false)
        .orderBy("createdAt", descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      }

      return snapshot.docs.first;
    });
  }

  /// ==============================
  /// Notice Count
  /// ==============================

  static Stream<int> getNoticeCount() {
    return _firestore
        .collection("notices")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  /// ==============================
  /// Assignment Count
  /// ==============================

  static Stream<int> getAssignmentCount() {
    return _firestore
        .collection("assignments")
        .where("completed", isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  /// ==============================
  /// Marketplace Count
  /// ==============================

  static Stream<int> getMarketplaceCount() {
    return _firestore
        .collection("marketplace")
        .where("isSold", isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  /// ==============================
  /// Lost & Found Count
  /// ==============================

  static Stream<int> getLostFoundCount() {
    return _firestore
        .collection("lost_found")
        .where("claimed", isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  /// ==============================
  /// Timetable Count
  /// ==============================

  static Stream<int> getTimetableCount() {
    return _firestore
        .collection("timetable")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  /// ==============================
  /// Today Name
  /// ==============================

  static String _todayName() {
    switch (DateTime.now().weekday) {
      case DateTime.monday:
        return "Monday";

      case DateTime.tuesday:
        return "Tuesday";

      case DateTime.wednesday:
        return "Wednesday";

      case DateTime.thursday:
        return "Thursday";

      case DateTime.friday:
        return "Friday";

      case DateTime.saturday:
        return "Saturday";

      default:
        return "Sunday";
    }
  }
}