import 'package:decordash/data/repositories/authentication/api_services.dart';
import 'package:decordash/features/product/model/product.dart';
import 'package:flutter/material.dart';
import 'package:decordash/features/home/controllers/product/product_controller.dart';
import 'package:decordash/features/notifications/controllers/notifications_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StartPageController extends GetxController {

  static StartPageController get instance => Get.find();
  final ScrollController scrollController = ScrollController();
  double _scrollControllerOffset = 0.0;
  List<NewProduct> products = [];
  double get scrollControllerOffset => _scrollControllerOffset;

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    Get.put(NotificationsController());
    Get.put(ProductController());
    super.onInit();
  }

  void _scrollListener() {
    _scrollControllerOffset = scrollController.offset;
    update();
  }
  Future<List<dynamic>> getProducts(int page) async {
    var token = GetStorage().read('token');
    // LoggerHelper.warning(token.toString());

    if (token == null) {
      print("Token is null");
      return [];
    } else {
      print(token);
    }

    try {
      var r = await HttpService.instance.getProducts(page, token);

      products = r.map((e) => NewProduct.fromJson(e)).toList();
      return r.toList();
    } catch (e) {
      return [];
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
