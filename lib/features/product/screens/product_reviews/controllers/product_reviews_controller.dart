import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/features/home/model/review_model.dart';
import 'package:decordash/utils/http/http_client.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:decordash/data/repositories/product/product.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  Future<void> addReview(Review review) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      FullScreenLoader.openLoadingDialog(
          'Adding review...', 'assets/animations/animation-of-docer.json');
      var r = await THttpHelper.postBearerAuth(
          'product/rate-product', GetStorage().read("token"), {
        "productId": product.id,
        "rate": review.rating,
        "description": review.comment
      });
      print(r.body);
      print(r.statusCode);

      if (r.statusCode == 403) {
        FullScreenLoader.stopLoading();
        Get.snackbar('Error', "You have already reviewed this product");
        return;
      }
      if (r.statusCode == 201) {
        FullScreenLoader.stopLoading();
        reviews.add(review);
        product.updateRates();
        update();

        Get.back();
        reviewController.clear();
        TLoaders.successSnackBar(title: "Review added successfully");
        return;
      }
      if (r.statusCode != 201) {
        FullScreenLoader.stopLoading();
        Get.snackbar('Error', 'Failed to add review');
        return;
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Get.snackbar('Error', 'Failed to add review');
      return;
    }
  }
}
