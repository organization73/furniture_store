import 'package:flutter/material.dart';
import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadinIcon,
    this.actions,
    this.leadingOnPress,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadinIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPress;

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      title: title,
      actions: actions,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Get.back(),
              icon: Icon(textDirection == TextDirection.ltr
                  ? IconsaxPlusLinear.arrow_left
                  : IconsaxPlusLinear.arrow_right_1),
            )
          : leadinIcon != null
              ? IconButton(
                  onPressed: leadingOnPress,
                  icon: Icon(leadinIcon),
                )
              : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
