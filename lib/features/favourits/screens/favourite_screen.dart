import 'package:decordashapp/common/widgets/loaders/animation_loader.dart';
import 'package:decordashapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:decordashapp/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:decordashapp/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/layouts/grid_layout.dart';
import 'package:decordashapp/features/favourits/controllers/favorite_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class FavouritsPage extends StatelessWidget {
  const FavouritsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoriteController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'favourites'.tr,
        ),
        forceMaterialTransparency: true,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: Obx(() => FutureBuilder(
                future: controller.favouriteProducts(),
                builder: (context, snapshot) {
                  final emptyWidget = AnimationLoaderWidget(
                    text: 'Whoops! Favourite List is Empty...',
                    animation: TImages.emptyFavorites,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionpress: () => Get.back(),
                  );
                  const loader = VerticalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      nothingFound: emptyWidget,
                      loader: loader);
                  if (widget != null) return widget;

                  final products = snapshot.data!;

                  return GridLayout(
                      mainAxisExtent:
                          TDeviceUtils.getScreenOrientation(context) ==
                                  Orientation.portrait
                              ? TDeviceUtils.getScreenHeight() * 0.31
                              : TDeviceUtils.getScreenHeight() * 0.4,
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        return ProductCardVerical(
                          product: products[index],
                        );
                      });
                })),
          ),
        ),
      ),
    );
  }
}
