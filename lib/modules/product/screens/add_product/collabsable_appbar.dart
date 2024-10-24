import 'package:decordashapp/modules/product/screens/add_product/widgets/add_single_product_screen.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CollapsingAppbarWithTabsPage extends StatelessWidget {
  const CollapsingAppbarWithTabsPage({super.key});

  void _onFabPressed(BuildContext context, TabController tabController) {
    switch (tabController.index) {
      case 0:
        // Action for the first tab
        Get.showSnackbar(const GetSnackBar(
          title: "Frrrrrr",
          message: "Add RRRRRR",
        ));
        break;
      case 1:
        // Action for the second tab
        Get.showSnackbar(const GetSnackBar(
          title: "Room",
          message: "Add Room",
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: TDeviceUtils.getScreenHeight() * 0.14,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  title: Text('Add Product',
                      style: Theme.of(context).textTheme.titleMedium),
                  titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
                  background:
                      Image.asset(ImageStrings.addBanner, fit: BoxFit.cover),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    dividerHeight: 0,
                    tabs: _tabs,
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: const TabBarView(
            children: [
              AddSingleProduct(),
              Text('Room'),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              child: const Icon(IconsaxPlusLinear.add),
              onPressed: () {
                final tabController = DefaultTabController.of(context);
                _onFabPressed(context, tabController);
              },
            );
          },
        ),
      ),
    );
  }
}

const _tabs = [
  Tab(icon: Icon(IconsaxPlusLinear.building), text: "Furniture"),
  Tab(icon: Icon(IconsaxPlusLinear.building_3), text: "Room"),
];

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => TDeviceUtils.getAppBarHeight();
  @override
  double get maxExtent => TDeviceUtils.getAppBarHeight();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
