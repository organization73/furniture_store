import 'dart:convert';

import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/home/model/product_model.dart';
import 'package:decordash/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  final favourites = <String, bool>{}.obs;

  @override
  onInit() {
    super.onInit();
    initFavourites();
  }

  void initFavourites() {
    final json = TLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
          storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouritesToStorage();
      TLoaders.customToast(messege: 'Product has been added to favourites');
    } else {
      TLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      TLoaders.customToast(messege: 'Product has been removed from favourites');
    }
  }

  void saveFavouritesToStorage() {
    final encodedFavourites = json.encode(favourites);
    TLocalStorage.instance().saveData('favourites', encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    return await ProductRepo.instance
        .getFavouriteProducts(favourites.keys.toList());
  }
}
