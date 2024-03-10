import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordash/common/widgets/images/circular_image.dart';
import 'package:decordash/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/utils/constants/enums.dart';
import 'package:decordash/utils/constants/sizes.dart';

class FeaturedGalleryCard extends StatelessWidget {
  const FeaturedGalleryCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.vendor,
  });

  final bool showBorder;
  final void Function()? onTap;
  final VendorModel vendor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: CircularImage(
                isNetworkImage: true,
                imageUrl: vendor.image,
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BrandTitleTextWithVerifiedIcon(
                    title: vendor.name,
                    beandtextSize: TextSizes.medium,
                  ),
                  Text(
                    '${vendor.productsCount ?? 0} Products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
