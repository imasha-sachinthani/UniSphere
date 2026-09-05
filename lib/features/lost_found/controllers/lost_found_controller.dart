import '../models/lost_found_model.dart';
import '../services/lost_found_service.dart';

class LostFoundController {

  /// ==============================
  /// GET ALL ITEMS
  /// ==============================

  static Stream<List<LostFoundModel>>
  getItems() {
    return LostFoundService.getItems();
  }

  /// ==============================
  /// GET USER ITEMS
  /// ==============================

  static Stream<List<LostFoundModel>>
  getUserItems(String uid) {
    return LostFoundService.getUserItems(
      uid,
    );
  }

  /// ==============================
  /// ADD ITEM
  /// ==============================

  static Future<void> addItem(
      LostFoundModel item,
      ) {
    return LostFoundService.addItem(
      item,
    );
  }

  /// ==============================
  /// UPDATE ITEM
  /// ==============================

  static Future<void> updateItem(
      String id,
      LostFoundModel item,
      ) {
    return LostFoundService.updateItem(
      id,
      item,
    );
  }

  /// ==============================
  /// DELETE ITEM
  /// ==============================

  static Future<void> deleteItem(
      String id,
      ) {
    return LostFoundService.deleteItem(
      id,
    );
  }

  /// ==============================
  /// MARK AS CLAIMED
  /// ==============================

  static Future<void> markAsClaimed(
      String id,
      ) {
    return LostFoundService.markAsClaimed(
      id,
    );
  }

  /// ==============================
  /// MARK AS AVAILABLE
  /// ==============================

  static Future<void> markAsAvailable(
      String id,
      ) {
    return LostFoundService
        .markAsAvailable(id);
  }
}