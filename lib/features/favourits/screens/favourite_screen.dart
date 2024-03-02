import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/layouts/grid_layout.dart';
import 'package:furniture_store/common/widgets/products/product_card_vertical.dart';
import 'package:furniture_store/features/favourits/controllers/favorite_controller.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class FavouritsPage extends StatelessWidget {
  const FavouritsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      init: FavoriteController(),
      builder: (controller) {
        final favList = controller.getFavorites();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'favourites'.tr,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: favList.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Lottie.asset(
                          'assets/animations/no_favourits.json',
                          width: 250,
                          height: 250,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          'noFavourites'.tr,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: TSizes.pagePaddingSpace),
                      child: Column(
                        children: [
                          GridLayout(
                              itemCount: favList.length,
                              itemBuilder: (_, index) {
                                return const ProductCardVerical();
                              }),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
