import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/features/product/model/product_model.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  RxString selectedProductImage = ''.obs;
  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};
    images.add(product.productImage);
    selectedProductImage.value = product.productImage;
    images.addAll(product.productDetails.productListImages);
    return images.toList();
  }

  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(imageUrl: image),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
