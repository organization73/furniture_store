import 'package:flutter/material.dart';
import 'package:furniture_store/common/styles/shadows.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:furniture_store/common/widgets/icons/circular_icon.dart';
import 'package:furniture_store/common/widgets/images/rounded_image.dart';
import 'package:furniture_store/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:furniture_store/common/widgets/texts/product_price_text.dart';
import 'package:furniture_store/common/widgets/texts/product_title_text.dart';
import 'package:furniture_store/features/product/screens/product_details/product_details_screen.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardVerical extends StatelessWidget {
  const ProductCardVerical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(
        () => const ProductDetails(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      ),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            RoundedContainer(
              hight: 170,
              width: double.infinity,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.black : TColors.light,
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: RoundedImage(
                      imageUrl: TImages.productImage1,
                      applyImageRaduis: true,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    child: RoundedContainer(
                      raduis: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '25%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: CicularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Directionality(
                  textDirection: TextDirection.ltr, // Force LTR directionality

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProductTitleText(
                        title: 'Bed with red sheets and wodden frame',
                        smallSize: true,
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BrandTitleTextWithVerifiedIcon(
                            title: 'Sameh',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(TSizes.sm),
              child: Row(
                children: [
                  ProductPriceText(
                    price: 22.toStringAsFixed(1),
                  ),
                  const Spacer(),
                  const Icon(
                    Iconsax.star1,
                    color: Colors.amber,
                    size: TSizes.iconSm,
                  ),
                  const SizedBox(
                    width: TSizes.xs,
                  ),
                  Text(
                    2.toStringAsFixed(1),
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
