import 'package:flutter/material.dart';
import 'package:furniture_store/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title,
      this.showBackArrow = false,
      this.leadinIcon,
      this.actions,
      this.leadingOnPress});
  final Widget? title;
  final bool showBackArrow;
  final IconData? leadinIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPress;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: title,
      actions: actions,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left))
          : leadinIcon != null
              ? IconButton(onPressed: leadingOnPress, icon: Icon(leadinIcon))
              : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
