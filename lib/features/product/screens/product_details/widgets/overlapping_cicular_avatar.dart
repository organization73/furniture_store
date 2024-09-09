import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/features/product/model/product_model.dart';
import 'package:decordashapp/features/product/screens/product_reviews/product_review_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OverlappingCircularAvatar extends StatelessWidget {
  final ProductModel product;

  const OverlappingCircularAvatar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < product.rates.length; i++)
              Align(
                widthFactor: 0.5,
                // parent circle avatar.
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  // Child circle avatar
                  child: CircleAvatar(
                    radius: 10,
                    child: CachedNetworkImage(
                      imageUrl: product.rates[i].reviewerImage,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              )
          ],
        ),

        // this circle avatar we created add icon
        InkWell(
          onTap: () => Get.to(
            () => ProductReviewsScreen(
              product: product,
            ),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          ),
          child: const CircleAvatar(
            radius: 15,
            child: Icon(Iconsax.add_copy),
          ),
        )
      ],
    );
  }
}
