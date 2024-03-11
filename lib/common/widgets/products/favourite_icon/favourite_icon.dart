import 'package:decordash/common/widgets/icons/circular_icon.dart';
import 'package:decordash/features/favourits/controllers/favorite_controller.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());

    return Obx(() => CicularIcon(
          icon: controller.isFavourite(productId)
              ? Iconsax.heart
              : Iconsax.heart_copy,
          color: controller.isFavourite(productId) ? TColors.error : null,
          onPress: () => controller.toggleFavouriteProduct(productId),
        ));
  }
}
