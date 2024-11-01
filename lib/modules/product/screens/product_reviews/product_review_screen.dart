import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/modules/product/screens/product_reviews/widgets/user_review_card.dart';
import 'package:flutter/material.dart';

import 'package:decordashapp/modules/product/model/product_model.dart';
import 'package:decordashapp/modules/product/screens/product_reviews/add_review_screen.dart';
import 'package:decordashapp/modules/product/screens/product_reviews/controllers/product_reviews_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Reviews",
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BuildCTAButton(
            onPressed: () => Get.to(
                  () => AddReviewScreen(product: product),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.downToUp,
                ),
            text: 'Write your review'),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: GetBuilder<ProductReviewsController>(
            init: ProductReviewsController(product: product),
            builder: (controller) => controller.reviews.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.reviews.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          UserReviewCard(
                            product: product,
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                        ],
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "There are no Reviews...",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
