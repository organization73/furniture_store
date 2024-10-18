import 'package:flutter/material.dart';
import 'package:decordashapp/modules/home/controllers/product/product_controller.dart';
import 'package:get/get.dart';

class StartPageController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxDouble _scrollControllerOffset = 0.0.obs;

  RxDouble get scrollControllerOffset => _scrollControllerOffset;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    Get.put(ProductController());
  }

  void _scrollListener() {
    _scrollControllerOffset.value = scrollController.offset;
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
