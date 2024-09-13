import 'package:decordashapp/features/favourits/controllers/favorite_controller.dart';
import 'package:decordashapp/features/home/widgets/fade_appbar.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/layouts/grid_layout.dart';
import 'package:decordashapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:decordashapp/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:decordashapp/features/home/controllers/home_page_controller.dart';
import 'package:decordashapp/features/home/controllers/product/product_controller.dart';
import 'package:decordashapp/features/home/screens/all_products/all_products_screen.dart';
import 'package:decordashapp/features/home/widgets/banners_slider.dart';
import 'package:decordashapp/features/home/widgets/categories_section.dart';
import 'package:decordashapp/features/home/widgets/home_appbar.dart';
import 'package:decordashapp/features/home/widgets/room_section.dart';
import 'package:decordashapp/features/notifications/controllers/notifications_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartPageController>(
      init: StartPageController(),
      builder: (controller) {
        Get.lazyPut(() => FavoriteController());
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
                              top: TDeviceUtils.getScreenOrientation(context) ==
                                      Orientation.portrait
                                  ? TDeviceUtils.getScreenHeight() * 0.11
                                  : TDeviceUtils.getScreenHeight() * 0.23,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: TSizes.pagePaddingSpace),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HomeAppBar(
                                      controller:
                                          NotificationsController.instance),
                                  const SizedBox(
                                    height: TSizes.spaceBtwSections,
                                  ),
                                  const BuildCategoriesSection(),
                                  const SizedBox(
                                    height: TSizes.spaceBtwSections,
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
                              const ImageSlider(),
                              SectionHeading(
                                title: 'popularProducts'.tr,
                                onPress: () => Get.to(
                                  () => AllProductsScreen(
                                    title: 'popularProducts'.tr,
                                    futureMethod: productsController
                                        .fetchAllFeaturedProducts(),
                                  ),
                                  duration: const Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft,
                                ),
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwItems,
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
                                    mainAxisExtent: 265,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FadeAppBar(scrollOffset: controller.scrollControllerOffset),
            ],
          ),
        );
      },
    );
  }
}
