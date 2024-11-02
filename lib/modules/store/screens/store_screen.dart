import 'package:decordashapp/common/widgets/input_fields/custom_text_form_field.dart';
import 'package:decordashapp/modules/errors/screens/no_connection_screen.dart';
import 'package:decordashapp/modules/gallery/screens/all_galleries_screen.dart';
import 'package:decordashapp/modules/home/screens/search/search_screen.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/appbar/tabbar.dart';
import 'package:decordashapp/common/widgets/vendors/featured_gallery_card.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/layouts/grid_layout.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/modules/vendors/screens/vendor_products_screen.dart';
import 'package:decordashapp/modules/home/controllers/category_controller.dart';
import 'package:decordashapp/modules/home/controllers/vendor/vendor_controller.dart';
import 'package:decordashapp/modules/store/widgets/category_tab.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!NetworkManager.instance.isOnline) {
        return const ErrorScreen();
      } else {
        final vendorsController = Get.put(VendorController());
        final categories = CategoryController.instance.allCatedories;
        return DefaultTabController(
          length: categories.length,
          child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (_, innerBoxIsScrollable) {
                  return [
                    SliverAppBar(
                        pinned: true,
                        floating: true,
                        expandedHeight:
                            TDeviceUtils.getScreenHeight(context) * 0.4,
                        flexibleSpace: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: TSizes.pagePaddingSpace),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              const SizedBox(
                                height: TSizes.spaceBtwItems,
                              ),
                              CustomTextFormField(
                                hint: 'homeSearchBarHint'.tr,
                                prefixIcon: IconsaxPlusLinear.search_normal,
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
                                  () => const AllGalleriesScreen(),
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
                                  return Center(child: Text('noData'.tr));
                                }
                                return GridLayout(
                                    itemCount: vendorsController
                                        .featuredVendors.length,
                                    mainAxisExtent: 60,
                                    itemBuilder: (_, index) {
                                      final vendor = vendorsController
                                          .featuredVendors[index];
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
                                .map((category) =>
                                    Tab(child: Text(category.name)))
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
    });
  }
}
