import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furniture_store/data/repositories/product/product.dart';
import 'package:furniture_store/features/product/screens/add_review/reviews_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OverlappingCircularAvatar extends StatelessWidget {
  final Product product;
  final List randomImages = [
    'https://picsum.photos/id/1062/80/80',
    'https://picsum.photos/id/1066/80/80',
    'https://picsum.photos/id/1072/80/80',
    'https://picsum.photos/id/80/80/80'
  ];
  OverlappingCircularAvatar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < randomImages.length; i++)
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
                      imageUrl: randomImages[i],
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
            () => Reviews(
              product: product,
            ),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          ),
          child: const CircleAvatar(
            radius: 15,
            child: Icon(Iconsax.add),
          ),
        )
      ],
    );
  }
}
