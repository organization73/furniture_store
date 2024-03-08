import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/layouts/grid_layout.dart';
import 'package:furniture_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:furniture_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:furniture_store/features/home/controllers/home_page_controller.dart';
import 'package:furniture_store/features/home/controllers/product/product_controller.dart';
import 'package:furniture_store/features/home/screens/store_screen.dart';
import 'package:furniture_store/features/home/widgets/banners_slider.dart';
import 'package:furniture_store/features/home/widgets/categories_section.dart';
import 'package:furniture_store/features/home/widgets/home_appbar.dart';
import 'package:furniture_store/features/home/widgets/room_section.dart';
import 'package:furniture_store/features/home/widgets/search_bar.dart';
import 'package:furniture_store/features/home/widgets/top_gallaries_section.dart';
import 'package:furniture_store/features/notifications/controllers/notifications_controller.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsController = Get.put(ProductController());
    
    return GetBuilder<StartPageController>(
      init: StartPageController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                            padding: EdgeInsets.only(top: 100.h),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: TSizes.pagePaddingSpace),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HomeAppBar(
                                      controller:
                                          Get.find<NotificationsController>()),
                                  const BuildCategoriesSection(),
                                  SizedBox(
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
                                  () => const StoreScreen(),
                                  duration: const Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft,
                                ),
                              ),
                              SizedBox(
                                height: TSizes.spaceBtwItems,
                              ),
                              Obx(() {
                                if (productsController.isLoading.value) {
                                  return const VerticalProductShimmer();
                                }
                                if (productsController
                                    .featuredProducts.isEmpty) {
                                  return const Center(
                                      child: Text('No Products Found'));
                                }
                                return GridLayout(
                                    itemCount: productsController
                                    .featuredProducts.length,
                                    itemBuilder: (_, index) =>
                                         ProductCardVerical(product: productsController
                                    .featuredProducts[index],));
                              }),
                              const BuildTopGalleriesSection(),
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
      height: 90,
      color: Theme.of(context)
          .scaffoldBackgroundColor
          .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: BuildSearchBar(),
          ),
        ),
      ),
    );
  }
}
