// model/favorite_model.dart
import 'package:furniture_store/data/repositories/product/product.dart';

class FavoriteModel {
  List<Product> favorites = [];

  void toggleFavorite(Product product) {
    if (favorites.contains(product)) {
      favorites.remove(product);
    } else {
      favorites.add(product);
    }
  }

  bool isFavorite(Product product) {
    return favorites.contains(product);
  }

  List<Product> getFavorites() {
    return favorites;
  }

  void removeFavorite(Product product) {
    favorites.remove(product);
  }
}
