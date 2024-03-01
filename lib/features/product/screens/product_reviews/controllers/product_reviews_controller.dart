import 'package:flutter/material.dart';
import 'package:furniture_store/data/repositories/product/product.dart';
import 'package:get/get.dart';

class ProductReviewsController extends GetxController {
  final Product product;
  RxList<Review> reviews = RxList<Review>();
  final TextEditingController reviewController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ProductReviewsController({required this.product}) {
    reviews.value = product.rates.cast<Review>();
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is closed
    reviewController.clear();
    super.onClose();
  }

  void addReview(Review review) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Add the review to the controller's reviews list
    reviews.add(review);
    // Update the product's rates list
    // product.rates.add(review);
    // Update the product's rating based on the new review
    product.updateRates();
    // Notify listeners to rebuild the UI
    update();

    Get.back();
    reviewController.clear();
  }
}
