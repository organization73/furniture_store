import 'package:decordashapp/common/widgets/icons/circular_icon.dart';
import 'package:decordashapp/features/favourits/controllers/favorite_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final controller = FavoriteController.instance;

    return Obx(() => CicularIcon(
          height: 35,
          width: 35,
          size: TSizes.iconMd - 4,
          icon: controller.isFavourite(productId)
              ? Iconsax.heart
              : Iconsax.heart_copy,
          color: controller.isFavourite(productId)
              ? Theme.of(context).colorScheme.error
              : null,
          onPress: () => controller.toggleFavouriteProduct(productId),
        ));
  }
}
