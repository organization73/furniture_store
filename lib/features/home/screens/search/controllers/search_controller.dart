import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  static SearchPageController get instance => Get.find();
  final isLoading = false.obs;
  final isSearchSubmitted = false.obs;
  final _productRepo = ProductRepo.instance;
  RxList<ProductModel> searchProducts = <ProductModel>[].obs;
  TextEditingController searchController = TextEditingController();

  Future<void> fetchSearchProducts() async {
    try {
      isLoading.value = true;
      final searchProducts =
          await _productRepo.searchProducts(searchController.text);

      this.searchProducts.assignAll(searchProducts);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
      isSearchSubmitted.value = true;
    }
  }
}
