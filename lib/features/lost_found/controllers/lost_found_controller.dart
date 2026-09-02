import '../models/lost_found_model.dart';
import '../services/lost_found_service.dart';

class LostFoundController {
  static Stream<List<LostFoundModel>>
  getItems() {
    return LostFoundService.getItems();
  }

  static Future<void> addItem(
      LostFoundModel item) {
    return LostFoundService.addItem(item);
  }

  static Future<void> updateItem(
      String id,
      LostFoundModel item) {
    return LostFoundService.updateItem(
      id,
      item,
    );
  }

  static Future<void> deleteItem(
      String id) {
    return LostFoundService.deleteItem(id);
  }
}