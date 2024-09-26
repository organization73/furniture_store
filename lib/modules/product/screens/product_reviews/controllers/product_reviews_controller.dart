import 'package:flutter/material.dart';
import 'package:decordashapp/data/repositories/product/product.dart';
import 'package:decordashapp/modules/product/model/product_model.dart';
import 'package:get/get.dart';

class ProductReviewsController extends GetxController {
  final ProductModel product;
  RxList<Review> reviews = RxList<Review>();
  final TextEditingController reviewController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxInt selectedRating = 0.obs; // Observable for the selected rating

  ProductReviewsController({required this.product}) {
    reviews.value = product.rates.cast<Review>();
  }

  @override
  void onClose() {
    reviewController.clear();
    super.onClose();
  }

  void updateSelectedRating(int rating) {
    selectedRating.value = rating;
  }

  void addReview(Review review) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    reviews.add(review);
    product.updateRates();
    update();

    Get.back();
    reviewController.clear();
  }
}
