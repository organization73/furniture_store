import 'package:decordashapp/modules/product/screens/add_product/widgets/add_single_product_screen.dart';
import 'package:decordashapp/modules/product/screens/add_product/widgets/tabs_background_widget.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class AddProductsTabsPage extends StatelessWidget {
  const AddProductsTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: Builder(
            builder: (context) {
              final tabController = DefaultTabController.of(context);
              return FloatingActionButton(
                onPressed: () {
                  if (tabController.index == 0) {
                    // Action for the first tab
                    print("Action for Furniture tab");
                  } else if (tabController.index == 1) {
                    // Action for the second tab
                    print("Action for Room tab");
                  }
                },
                child: const Icon(Icons.add),
              );
            },
          ),
          body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrollable) {
              return [
                SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: TDeviceUtils.getScreenHeight() * 0.1,
                    flexibleSpace: const TabBackground(),
                    bottom: TabBar(
                      dividerHeight: 0,
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                      tabs: const <Widget>[
                        Tab(
                            iconMargin: EdgeInsets.only(bottom: 10),
                            icon: Icon(IconsaxPlusLinear.building),
                            text: "Furniture"),
                        Tab(
                            iconMargin: EdgeInsets.only(bottom: 10),
                            icon: Icon(IconsaxPlusLinear.building_3),
                            text: "Room"),
                      ],
                    ))
              ];
            },
            body: const TabBarView(
              children: <Widget>[
                AddSingleProduct(),
                Center(
                  child: Text("It's rainy here"),
                ),
              ],
            ),
          ),
        ));
  }
}
