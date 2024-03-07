import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/appbar/tabbar.dart';
import 'package:furniture_store/common/widgets/galleries/featured_gallery_card.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/layouts/grid_layout.dart';
import 'package:furniture_store/features/gallery/screens/all_galleries/all_galleries_screen.dart';
import 'package:furniture_store/features/home/controllers/category_controller.dart';
import 'package:furniture_store/features/home/widgets/category_tab.dart';
import 'package:furniture_store/features/home/widgets/search_bar.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    backgroundColor: THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                    expandedHeight: 365.h,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.symmetric(
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
                          GridLayout(
                              itemCount: 4,
                              mainAxisExtent: 80.h,
                              itemBuilder: (_, index) {
                                return const FeaturedGalleryCard(
                                  showBorder: true,
                                );
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
