import 'package:flutter/material.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/helpers/helper_functions.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderEffect extends StatelessWidget {
  const ShimmerLoaderEffect(
      {super.key,
      required this.width,
      required this.height,
      this.raduis = 15,
      this.color});
  final double width, height, raduis;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
        baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color ?? (dark ? TColors.darkerGrey : TColors.white),
              borderRadius: BorderRadius.circular(raduis)),
        ));
  }
}
