import '../models/search_item_model.dart';
import '../services/search_service.dart';

class GlobalSearchController {
  const GlobalSearchController._();

  static Future<List<SearchItemModel>> search(
      String keyword,
      ) async {
    return SearchService.search(keyword);
  }
}