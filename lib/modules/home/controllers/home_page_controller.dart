import 'package:decordashapp/modules/favourits/controllers/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/modules/home/controllers/product/product_controller.dart';
import 'package:get/get.dart';

class StartPageController extends GetxController {
  final ScrollController scrollController = ScrollController();
  double _scrollControllerOffset = 0.0;

  double get scrollControllerOffset => _scrollControllerOffset;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    Get.lazyPut(() => FavoriteController());
    Get.put(ProductController());
  }

  void _scrollListener() {
    _scrollControllerOffset = scrollController.offset;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
