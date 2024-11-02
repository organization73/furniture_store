import 'package:cached_network_image/cached_network_image.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/modules/vendors/screens/vendor_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordashapp/common/widgets/vendors/featured_gallery_card.dart';
import 'package:decordashapp/modules/vendors/models/vendor_model.dart';

import 'package:decordashapp/utils/constants/sizes.dart';

import 'package:get/get.dart';

class VendorShowCase extends StatelessWidget {
  const VendorShowCase({
    super.key,
    required this.images,
    required this.vendor,
  });
  final VendorModel vendor;
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        () => VendorProductsScreen(
          vendor: vendor,
        ),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      ),
      child: RoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: true,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            FeaturedGalleryCard(
              showBorder: false,
              vendor: vendor,
            ),
            const SizedBox(
              height: TSizes.sm,
            ),
            Row(
                children: images
                    .map((image) => galleryTopProductsWidget(image, context))
                    .toList())
          ],
        ),
      ),
    );
  }

  Widget galleryTopProductsWidget(String image, context) {
    return Expanded(
      child: RoundedContainer(
        hight: 80,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        margin: const EdgeInsets.only(right: TSizes.sm),
        padding: const EdgeInsets.all(TSizes.md),
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, progress) =>
              const ShimmerLoaderEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
