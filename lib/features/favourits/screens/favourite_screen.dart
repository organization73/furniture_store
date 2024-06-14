import 'package:decordash/common/widgets/loaders/animation_loader.dart';
import 'package:decordash/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:decordash/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordash/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/layouts/grid_layout.dart';
import 'package:decordash/features/favourits/controllers/favorite_controller.dart';
import 'package:decordash/utils/constants/sizes.dart';

import 'package:get/get.dart';

class FavouritsPage extends StatelessWidget {
  const FavouritsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'favourites'.tr,
        ),
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
                    animation: 'assets/animations/no_favourits.json',
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
                      mainAxisExtent: 265.r,
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
