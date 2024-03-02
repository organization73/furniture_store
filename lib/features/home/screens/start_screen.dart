import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/layouts/grid_layout.dart';
import 'package:furniture_store/common/widgets/products/product_card_vertical.dart';
import 'package:furniture_store/features/home/screens/store_screen.dart';
import 'package:furniture_store/features/home/widgets/ads_banner.dart';
import 'package:furniture_store/features/home/widgets/categories_section.dart';
import 'package:furniture_store/features/home/widgets/home_appbar.dart';
import 'package:furniture_store/features/home/widgets/room_section.dart';
import 'package:furniture_store/features/home/widgets/search_bar.dart';
import 'package:furniture_store/features/home/widgets/top_gallaries_section.dart';
import 'package:furniture_store/features/favourits/controllers/favorite_controller.dart';
import 'package:furniture_store/features/notifications/controllers/notifications_controller.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _FadeAppBarTutorialState();
}

class _FadeAppBarTutorialState extends State<StartPage> {
  late ScrollController _scrollController;
  double _scrollControllerOffset = 0.0;

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());
    Get.put(FavoriteController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    PrimaryHeaderContainer(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: TSizes.pagePaddingSpace),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeAppBar(controller: controller),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: TSizes.pagePaddingSpace),
                      child: Column(
                        children: [
                          const CarouselSliderPage(),
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
                          GridLayout(
                              itemCount: 4,
                              itemBuilder: (_, index) =>
                                  const ProductCardVerical()),
                          // const ProductGrid(),
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
          PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 16.0),
            child: FadeAppBar(scrollOffset: _scrollControllerOffset),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: const BuildSearchBar(),
          ),
        ),
      ),
    );
  }
}
