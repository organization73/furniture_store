import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:furniture_store/common/widgets/images/circular_image.dart';
import 'package:furniture_store/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:furniture_store/utils/constants/enums.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

class FeaturedGalleryCard extends StatelessWidget {
  const FeaturedGalleryCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;

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
            const Flexible(
              child: CircularImage(
                isNetworkImage: false,
                imageUrl: TImages.user,
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
                  const BrandTitleTextWithVerifiedIcon(
                    title: 'Ali',
                    beandtextSize: TextSizes.medium,
                  ),
                  Text(
                    '24 Products',
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
