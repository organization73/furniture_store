import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/data/repositories/product/product.dart';
import 'package:furniture_store/features/product/screens/product_reviews/add_review.dart';
import 'package:furniture_store/features/product/screens/product_reviews/controllers/product_reviews_controller.dart';
import 'package:furniture_store/features/product/screens/product_reviews/widgets/user_review_card.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Reviews",
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ElevatedButton(
            onPressed: () => Get.to(
                  () => AddReview(product: product),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.downToUp,
                ),
            child: const Text('Write your review')),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: GetBuilder<ProductReviewsController>(
            init: ProductReviewsController(product: product),
            builder: (controller) => controller.reviews.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.reviews.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          UserReviewCard(
                            review: controller.reviews[index],
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "There are no Reviews...",
                      style: TextStyle(
                          fontSize: 21.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
