import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:furniture_store/data/repositories/product/product.dart';
import 'package:furniture_store/features/product/screens/product_reviews/controllers/product_reviews_controller.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddReview extends StatelessWidget {
  final Product product;
  const AddReview({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductReviewsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Write your review",
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Column(
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Iconsax.star1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onRatingUpdate: (rating) {
                  controller.updateSelectedRating(rating.toInt());
                },
              ),
              TextFormField(
                controller: controller.reviewController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Type your review here...",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your review';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ElevatedButton(
            onPressed: () {
              controller.addReview(Review(
                reviewerName: "UserClass",
                rating: controller.selectedRating
                    .value, // Use the selected rating from the controller
                comment: controller.reviewController.text,
                timestamp: DateTime.now().toString(),
              ));
            },
            child: const Text('Continue')),
      ),
    );
  }
}
