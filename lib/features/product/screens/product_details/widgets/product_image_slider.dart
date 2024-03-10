import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/appbar/custom_appbar.dart';
import 'package:decordash/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:decordash/common/widgets/icons/circular_icon.dart';
import 'package:decordash/common/widgets/images/rounded_image.dart';
import 'package:decordash/features/home/controllers/product/images_controller.dart';
import 'package:decordash/features/home/model/product_model.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    return CurvedEdgesWidget(
      child: Container(
        color: isDark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: Center(
                    child: Obx(() {
                      final image = controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (_, __, progress) =>
                              CircularProgressIndicator(
                            value: progress.progress,
                            color: TColors.primary,
                          ),
                        ),
                      );
                    }),
                  ),
                )),
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemBuilder: (_, index) => Obx(
                    () {
                      final imageSelected =
                          controller.selectedProductImage.value ==
                              images[index];
                      return RoundedImage(
                          width: 80,
                          onPress: () => controller.selectedProductImage.value =
                              images[index],
                          isNetworkImage: true,
                          border: Border.all(
                              color: imageSelected
                                  ? TColors.primary
                                  : Colors.transparent),
                          padding: const EdgeInsets.all(TSizes.sm),
                          backgroundColor:
                              isDark ? TColors.dark : TColors.white,
                          imageUrl: images[index]);
                    },
                  ),
                  separatorBuilder: (_, __) => SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemCount: images.length,
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
                    icon: Iconsax.heart,
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
