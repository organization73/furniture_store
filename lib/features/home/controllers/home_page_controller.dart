import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:decordash/features/notifications/controllers/notifications_controller.dart';
import 'package:get/get.dart';

class StartPageController extends GetxController {
  static StartPageController get instance => Get.find();
  final ScrollController scrollController = ScrollController();
  double _scrollControllerOffset = 0.0;
  List<ProductModel> products = [];
  double get scrollControllerOffset => _scrollControllerOffset;

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    Get.put(NotificationsController());
    // Get.put(ProductController());
    Get.put(ProductRepo());
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
