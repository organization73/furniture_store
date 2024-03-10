import 'package:flutter/material.dart';
import 'package:decordash/features/favourits/controllers/favorite_controller.dart';
import 'package:decordash/features/home/controllers/product/product_controller.dart';
import 'package:decordash/features/notifications/controllers/notifications_controller.dart';
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
