import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/appbar/tabbar.dart';
import 'package:furniture_store/common/widgets/galleries/featured_gallery_card.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/layouts/grid_layout.dart';
import 'package:furniture_store/features/home/widgets/category_tab.dart';
import 'package:furniture_store/features/home/widgets/search_bar.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
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
                            onPress: () {},
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
                    bottom: const CustomTabBar(tabs: [
                      Tab(
                        child: Text('Chairs'),
                      ),
                      Tab(
                        child: Text('Sofas'),
                      ),
                      Tab(
                        child: Text('Beds'),
                      ),
                      Tab(
                        child: Text('Lambs'),
                      ),
                    ]))
              ];
            },
            body: const TabBarView(
              children: [
                CategoryTab(),
                CategoryTab(),
                CategoryTab(),
                CategoryTab(),
              ],
            )),
      ),
    );
  }
}
