import '../models/notice_model.dart';
import '../services/notice_service.dart';

class NoticeController {

  /// =====================================
  /// GET ALL NOTICES
  /// =====================================

  static Stream<List<NoticeModel>>
  getNotices() {

    return NoticeService.getNotices();
  }

  /// =====================================
  /// GET PINNED NOTICES
  /// =====================================

  static Stream<List<NoticeModel>>
  getPinnedNotices() {

    return NoticeService.getPinnedNotices();
  }

  /// =====================================
  /// GET LATEST NOTICES
  /// Dashboard
  /// =====================================

  static Stream<List<NoticeModel>>
  getLatestNotices({

    int limit = 5,

  }) {

    return NoticeService.getLatestNotices(
      limit: limit,
    );
  }
}