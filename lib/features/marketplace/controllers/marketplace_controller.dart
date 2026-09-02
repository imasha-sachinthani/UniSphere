import '../models/product_model.dart';
import '../services/marketplace_service.dart';

class MarketplaceController {

  static Stream<List<ProductModel>>
  getProducts() {
    return MarketplaceService.getProducts();
  }

  static Future<void> addProduct(
      ProductModel product) {
    return MarketplaceService.addProduct(product);
  }

  static Future<void> updateProduct(
      String id,
      ProductModel product) {
    return MarketplaceService.updateProduct(
      id,
      product,
    );
  }

  static Future<void> deleteProduct(
      String id) {
    return MarketplaceService.deleteProduct(id);
  }
}