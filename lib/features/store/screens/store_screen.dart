import 'package:decordashapp/common/widgets/input_fields/custom_text_form_field.dart';
import 'package:decordashapp/features/home/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordashapp/common/widgets/appbar/tabbar.dart';
import 'package:decordashapp/common/widgets/vendors/featured_gallery_card.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/layouts/grid_layout.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/features/gallery/screens/all_galleries/all_galleries_screen.dart';
import 'package:decordashapp/features/gallery/screens/vendor_products/vendor_products.dart';
import 'package:decordashapp/features/home/controllers/category_controller.dart';
import 'package:decordashapp/features/home/controllers/vendor/vendor_controller.dart';
import 'package:decordashapp/features/store/widgets/category_tab.dart';

import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vendorsController = Get.put(VendorController());

    final categories = CategoryController.instance.featuredCatedories;
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
                    expandedHeight: 290.h,
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
                          CustomTextFormField(
                            hint: 'homeSearchBarHint'.tr,
                            prefixIcon: Iconsax.search_normal_copy,
                            readOnly: true,
                            filled: true,
                            onTap: () => Get.to(
                              () => const SearchScreen(),
                              duration: const Duration(milliseconds: 300),
                              transition: Transition.downToUp,
                            ),
                          ),
                          SectionHeading(
                            title: 'featuredGalleries'.tr,
                            onPress: () => Get.to(
                              () => const AllGalleriesPage(),
                              duration: const Duration(milliseconds: 300),
                              transition: Transition.rightToLeft,
                            ),
                          ),
                          Obx(() {
                            if (vendorsController.isLoading.value) {
                              return ShimmerLoaderEffect(
                                width: 80.r,
                                height: 80.r,
                                raduis: 10.r,
                              );
                            }
                            if (vendorsController.featuredVendors.isEmpty) {
                              return Center(child: Text('noData'.tr));
                            }
                            return GridLayout(
                                itemCount:
                                    vendorsController.featuredVendors.length,
                                mainAxisExtent: 60.h,
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
