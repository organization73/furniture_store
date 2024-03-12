import 'package:flutter/material.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/constants/sizes.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {super.key,
      this.width,
      this.hight,
      this.raduis = TSizes.cardRadiusLg,
      this.child,
      this.showBorder = false,
      this.borderColor = TColors.borderPrimary,
      this.gradient = false,
      this.backgroundColor = TColors.white,
      this.padding,
      this.margin});

  final double? width;
  final double? hight;
  final double raduis;
  final Widget? child;
  final bool showBorder;
  final bool gradient;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: hight,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          gradient: gradient
              ? RadialGradient(colors: [
                  TColors.lightContainer.withOpacity(0.7),
                  TColors.grey.withOpacity(0.7)
                ], radius: 2)
              : null,
          color: !gradient ? backgroundColor : null,
          borderRadius: BorderRadius.circular(raduis),
          border: showBorder ? Border.all(color: borderColor) : null),
      child: child,
    );
  }
}
