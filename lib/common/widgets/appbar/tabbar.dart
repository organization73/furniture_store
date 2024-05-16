import 'package:flutter/material.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/device/device_utility.dart';
import 'package:decordash/utils/helpers/helper_functions.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : TColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: TColors.primary,
        unselectedLabelColor: TColors.darkGrey,
        labelStyle: Theme.of(context).textTheme.titleMedium,
        labelColor: dark ? TColors.white : TColors.primary,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
