import 'package:flutter/material.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/helpers/helper_functions.dart';

class CicularIcon extends StatelessWidget {
  const CicularIcon({
    super.key,
    this.width,
    this.height,
    this.size = TSizes.iconMd,
    required this.icon,
    this.color,
    this.backgrounfColor,
    this.onPress,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgrounfColor;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgrounfColor != null
              ? backgrounfColor!
              : THelperFunctions.isDarkMode(context)
                  ? TColors.black.withOpacity(0.9)
                  : TColors.white.withOpacity(0.9)),
      child: IconButton(
          onPressed: onPress,
          icon: Icon(
            icon,
            color: color,
            size: size,
          )),
    );
  }
}
