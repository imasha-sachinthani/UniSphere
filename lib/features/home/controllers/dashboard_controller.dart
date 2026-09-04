import '../services/dashboard_service.dart';

class DashboardController {
  static Stream<int> assignments() =>
      DashboardService.assignmentCount();

  static Stream<int> timetable() =>
      DashboardService.timetableCount();

  static Stream<int> notices() =>
      DashboardService.noticeCount();

  static Stream<int> marketplace() =>
      DashboardService.marketplaceCount();

  static Stream<int> lostFound() =>
      DashboardService.lostFoundCount();
}