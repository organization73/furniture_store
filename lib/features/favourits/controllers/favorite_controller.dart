// controller/favorite_controller.dart
import 'package:decordash/data/repositories/product/product.dart';
import 'package:decordash/features/favourits/models/favorite_model.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();
  final FavoriteModel favoriteModel = FavoriteModel();

  void toggleFavorite(Product product) {
    favoriteModel.toggleFavorite(product);
    update();
  }

  bool isFavorite(Product product) {
    return favoriteModel.isFavorite(product);
  }

  List<Product> getFavorites() {
    return favoriteModel.getFavorites();
  }

  void removeFavorite(Product product) {
    favoriteModel.removeFavorite(product);
    update();
  }
}
