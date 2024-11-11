import 'package:decordashapp/modules/errors/screens/no_connection_screen.dart';
import 'package:decordashapp/modules/favourites/controllers/favorite_controller.dart';
import 'package:decordashapp/modules/home/widgets/banner_slider_widget.dart';
import 'package:decordashapp/modules/home/widgets/fade_appbar.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/layouts/grid_layout.dart';
import 'package:decordashapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:decordashapp/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordashapp/modules/home/controllers/home_page_controller.dart';
import 'package:decordashapp/modules/home/controllers/product/product_controller.dart';
import 'package:decordashapp/modules/home/screens/all_products/all_products_screen.dart';
import 'package:decordashapp/modules/home/widgets/categories_section.dart';
import 'package:decordashapp/modules/home/widgets/home_appbar.dart';
import 'package:decordashapp/modules/rooms/widgets/room_section.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!NetworkManager.instance.isOnline) {
        return const ErrorScreen();
      } else {
        Get.put(FavoriteController());
        final controller = Get.put(StartPageController());
        final productsController = ProductController.instance;

        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        PrimaryHeaderContainer(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: TDeviceUtils.getStatusBarHeight(context) +
                                    65),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: TSizes.pagePaddingSpace),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HomeAppBar(),
                                  SizedBox(
                                    height: TSizes.spaceBtwSections / 2,
                                  ),
                                  BuildCategoriesSection(),
                                  SizedBox(
                                    height: TSizes.spaceBtwSections * 2,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: TSizes.pagePaddingSpace),
                          child: Column(
                            children: [
                              const BannerSlider(),
                              SectionHeading(
                                title: 'popularProducts'.tr,
                                onPress: () => Get.to(
                                  () => AllProductsScreen(
                                    title: 'popularProducts'.tr,
                                    futureMethod: productsController
                                        .fetchAllFeaturedProducts(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwItems / 2,
                              ),
                              Obx(() {
                                if (productsController.isLoading.value) {
                                  return const VerticalProductShimmer();
                                }
                                if (productsController
                                    .featuredProducts.isEmpty) {
                                  return Center(child: Text('noProducts'.tr));
                                }
                                return GridLayout(
                                    mainAxisExtent:
                                        TDeviceUtils.getScreenOrientation(
                                                    context) ==
                                                Orientation.portrait
                                            ? TDeviceUtils.getScreenHeight(
                                                    context) *
                                                0.32
                                            : TDeviceUtils.getScreenHeight(
                                                    context) *
                                                0.4,
                                    itemCount: productsController
                                        .featuredProducts.length,
                                    itemBuilder: (_, index) =>
                                        ProductCardVerical(
                                          product: productsController
                                              .featuredProducts[index],
                                        ));
                              }),
                              const SizedBox(
                                height: TSizes.spaceBtwSections * 2,
                              ),
                              const BuildRoomsSection(),
                              const SizedBox(
                                height: TSizes.spaceBtwSections * 2,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FadeAppBar(scrollOffset: controller.scrollControllerOffset.value),
            ],
          ),
        );
      }
    });
  }
}
