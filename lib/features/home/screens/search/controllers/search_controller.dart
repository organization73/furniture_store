import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  static SearchPageController get instance => Get.find();
  final isSearchSubmitted = false.obs;
  final _productRepo = ProductRepo.instance;
  TextEditingController searchController = TextEditingController();

  Future<List<ProductModel>> fetchSearchProducts() async {
    try {
      final searchProducts =
          await _productRepo.searchProducts(1,searchController.text);
      return searchProducts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      return [];
    } finally {
      isSearchSubmitted.value = true;
    }
  }
}
