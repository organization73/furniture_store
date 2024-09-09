import 'package:decordashapp/common/widgets/input_fields/custom_text_form_field.dart';
import 'package:decordashapp/features/favourits/controllers/favorite_controller.dart';
import 'package:decordashapp/features/home/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
                            padding: EdgeInsets.only(top: 85.h),
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
                                    mainAxisExtent: 265.r,
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

class FadeAppBar extends StatelessWidget {
  final double scrollOffset;
  const FadeAppBar({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      color: Theme.of(context)
          .scaffoldBackgroundColor
          .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.pagePaddingSpace),
              child: CustomTextFormField(
                hint: 'homeSearchBarHint'.tr,
                prefixIcon: Iconsax.search_normal_copy,
                readOnly: true,
                filled: true,
                onTap: () => Get.to(
                  () => const SearchScreen(),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.downToUp,
                ),
              )),
        ),
      ),
    );
  }
}
