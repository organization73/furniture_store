import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furniture_store/features/home/model/product_model.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.defaultSpace * 2,
                        horizontal: TSizes.defaultSpace),
                    child: CachedNetworkImage(imageUrl: image),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: const Text('Close')),
                    ),
                  )
                ],
              ),
            ));
  }
}
