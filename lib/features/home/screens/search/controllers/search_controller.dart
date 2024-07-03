import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  static int pagenumberOfsearch = 1;
  static SearchPageController get instance => Get.find();

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pagenumberOfsearch = 1;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pagenumberOfsearch = 1;
  }

  final isSearchSubmitted = false.obs;
  final _productRepo = ProductRepo.instance;
  TextEditingController searchController = TextEditingController();

  Future<List<ProductModel>> fetchSearchProducts(int page) async {
    try {
      final searchProducts =
          await _productRepo.searchProducts(page, searchController.text.trim());
      return searchProducts;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
      return [];
    } finally {
      isSearchSubmitted.value = true;
    }
  }
}
