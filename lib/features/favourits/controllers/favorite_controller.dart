import 'dart:convert';

import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  final favourites = <String, bool>{}.obs;

  @override
  onInit() {
    super.onInit();
    initFavourites();
  }

  void initFavourites() {
    // TODO TLOCAl

    final json = GetStorage().read(UserController.instance.user.value.id);
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
      // TODO TLOCAl

      // TLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      TLoaders.customToast(messege: 'Product has been removed from favourites');
    }
  }

  void saveFavouritesToStorage() {
    final encodedFavourites = json.encode(favourites);
    // TODO TLOCAl
    GetStorage()
        .write(UserController.instance.user.value.id, encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    return await ProductRepo.instance
        .getFavouriteProducts(favourites.keys.toList());
  }
}
