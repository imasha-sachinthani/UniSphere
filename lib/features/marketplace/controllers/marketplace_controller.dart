import '../models/product_model.dart';
import '../services/marketplace_service.dart';

class MarketplaceController {
  MarketplaceController._();

  /// ---------------- GET PRODUCTS ----------------

  static Stream<List<ProductModel>>
  getProducts() {
    return MarketplaceService.getProducts();
  }

  /// ---------------- ADD PRODUCT ----------------

  static Future<void> addProduct(
      ProductModel product,
      ) {
    return MarketplaceService.addProduct(
      product,
    );
  }

  /// ---------------- UPDATE PRODUCT ----------------

  static Future<void> updateProduct(
      String id,
      ProductModel product,
      ) {
    return MarketplaceService.updateProduct(
      id,
      product,
    );
  }

  /// ---------------- DELETE PRODUCT ----------------

  static Future<void> deleteProduct(
      String id,
      ) {
    return MarketplaceService.deleteProduct(
      id,
    );
  }

  /// ---------------- SOLD ----------------

  static Future<void> markAsSold({
    required String productId,
    required bool sold,
  }) {
    return MarketplaceService.markAsSold(
      productId,
      sold,
    );
  }

  /// ---------------- FAVORITE ----------------

  static Future<void> toggleFavorite({
    required String productId,
    required String userId,
    required bool isFavorite,
  }) {
    return MarketplaceService.toggleFavorite(
      productId: productId,
      userId: userId,
      isFavorite: isFavorite,
    );
  }

  /// ---------------- CHECK FAVORITE ----------------

  static Stream<bool> isFavorite({
    required String productId,
    required String userId,
  }) {
    return MarketplaceService.isFavorite(
      productId: productId,
      userId: userId,
    );
  }
}