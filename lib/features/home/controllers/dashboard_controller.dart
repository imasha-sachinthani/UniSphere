import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/dashboard_service.dart';

class DashboardController {

  /// =========================
  /// Next Class
  /// =========================

  static Stream<QueryDocumentSnapshot?>
  nextClass() {
    return DashboardService.getNextClass();
  }

  /// =========================
  /// Upcoming Assignment
  /// =========================

  static Stream<QueryDocumentSnapshot?>
  upcomingAssignment() {
    return DashboardService.getUpcomingAssignment();
  }

  /// =========================
  /// Latest Notice
  /// =========================

  static Stream<QueryDocumentSnapshot?>
  latestNotice() {
    return DashboardService.getLatestNotice();
  }

  /// =========================
  /// Latest Marketplace Item
  /// =========================

  static Stream<QueryDocumentSnapshot?>
  latestMarketplace() {
    return DashboardService.getLatestMarketplace();
  }

  /// =========================
  /// Latest Lost & Found
  /// =========================

  static Stream<QueryDocumentSnapshot?>
  latestLostFound() {
    return DashboardService.getLatestLostFound();
  }

  /// =========================
  /// Dashboard Counts
  /// =========================

  static Stream<int> assignmentCount() {
    return DashboardService.getAssignmentCount();
  }

  static Stream<int> noticeCount() {
    return DashboardService.getNoticeCount();
  }

  static Stream<int> marketplaceCount() {
    return DashboardService.getMarketplaceCount();
  }

  static Stream<int> lostFoundCount() {
    return DashboardService.getLostFoundCount();
  }

  static Stream<int> timetableCount() {
    return DashboardService.getTimetableCount();
  }
}