import '../models/notice_model.dart';
import '../services/notice_service.dart';

class NoticeController {
  static Stream<List<NoticeModel>> getNotices() {
    return NoticeService.getNotices();
  }

  static Future<void> addNotice(NoticeModel notice) {
    return NoticeService.addNotice(notice);
  }

  static Future<void> updateNotice(
    String id,
    NoticeModel notice,
  ) {
    return NoticeService.updateNotice(id, notice);
  }

  static Future<void> deleteNotice(String id) {
    return NoticeService.deleteNotice(id);
  }
}