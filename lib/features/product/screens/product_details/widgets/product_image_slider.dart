import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/appbar/custom_appbar.dart';
import 'package:furniture_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:furniture_store/common/widgets/icons/circular_icon.dart';
import 'package:furniture_store/common/widgets/images/rounded_image.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return CurvedEdgesWidget(
      child: Container(
        color: isDark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: const Center(
                    child: Image(image: AssetImage(TImages.productImage1)),
                  ),
                )),
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemBuilder: (_, index) => RoundedImage(
                      width: 80,
                      border: Border.all(color: TColors.primary),
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: isDark ? TColors.dark : TColors.white,
                      imageUrl: TImages.productImage1),
                  separatorBuilder: (_, __) => SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
              ),
            ),
            const CustomAppBar(
              showBackArrow: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: TSizes.sm),
                  child: CicularIcon(
                    icon: Iconsax.heart5,
                    color: Colors.red,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
