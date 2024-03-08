import 'package:flutter/material.dart';
import 'package:furniture_store/features/favourits/controllers/favorite_controller.dart';
import 'package:furniture_store/features/home/controllers/category_controller.dart';
import 'package:furniture_store/features/home/controllers/product/product_controller.dart';
import 'package:furniture_store/features/notifications/controllers/notifications_controller.dart';
import 'package:get/get.dart';

class StartPageController extends GetxController {
  final ScrollController scrollController = ScrollController();
  double _scrollControllerOffset = 0.0;

  double get scrollControllerOffset => _scrollControllerOffset;

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    Get.put(NotificationsController());
    Get.put(FavoriteController());
    Get.put(CategoryController());
    Get.put(ProductController());
    super.onInit();
  }

  void _scrollListener() {
    _scrollControllerOffset = scrollController.offset;
    update();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
