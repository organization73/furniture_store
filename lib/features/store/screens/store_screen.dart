import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/appbar/tabbar.dart';
import 'package:decordash/common/widgets/galleries/featured_gallery_card.dart';
import 'package:decordash/common/widgets/headings/section_heading.dart';
import 'package:decordash/common/widgets/layouts/grid_layout.dart';
import 'package:decordash/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordash/features/gallery/screens/all_galleries/all_galleries_screen.dart';
import 'package:decordash/features/gallery/screens/vendor_products/vendor_products.dart';
import 'package:decordash/features/home/controllers/category_controller.dart';
import 'package:decordash/features/home/controllers/vendor/vendor_controller.dart';
import 'package:decordash/features/home/widgets/category_tab.dart';
import 'package:decordash/features/home/widgets/search_bar.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCatedories;
    final vendorsController = VendorController.instance;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrollable) {
              return [
                SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    floating: true,
                    backgroundColor: THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                    expandedHeight: 365.h,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.pagePaddingSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          const BuildSearchBar(),
                          const SizedBox(
                            height: TSizes.sm,
                          ),
                          SectionHeading(
                            title: 'Featured Galleries',
                            onPress: () => Get.to(
                              () => const AllGalleriesPage(),
                              duration: const Duration(milliseconds: 300),
                              transition: Transition.rightToLeft,
                            ),
                          ),
                          Obx(() {
                            if (vendorsController.isLoading.value) {
                              return const ShimmerLoaderEffect(
                                width: 80,
                                height: 80,
                                raduis: 10,
                              );
                            }
                            if (vendorsController.featuredVendors.isEmpty) {
                              return const Center(child: Text('No Data Found'));
                            }
                            return GridLayout(
                                itemCount:
                                    vendorsController.featuredVendors.length,
                                mainAxisExtent: 80.h,
                                itemBuilder: (_, index) {
                                  final vendor =
                                      vendorsController.featuredVendors[index];
                                  return FeaturedGalleryCard(
                                    onTap: () => Get.to(
                                      () => VendorProductsScreen(
                                        vendor: vendor,
                                      ),
                                      duration:
                                          const Duration(milliseconds: 300),
                                      transition: Transition.rightToLeft,
                                    ),
                                    vendor: vendor,
                                    showBorder: true,
                                  );
                                });
                          })
                        ],
                      ),
                    ),
                    bottom: CustomTabBar(
                        tabs: categories
                            .map((category) => Tab(child: Text(category.name)))
                            .toList()))
              ];
            },
            body: TabBarView(
                children: categories
                    .map((category) => CategoryTab(category: category))
                    .toList())),
      ),
    );
  }
}
