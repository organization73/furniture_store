import 'package:flutter/material.dart';
import 'package:decordash/utils/constants/colors.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer(
      {super.key,
      this.width = 400,
      this.height = 400,
      this.raduis = 400,
      this.padding = 0,
      this.child,
      this.backgroungColor = TColors.white});
  final double? width;
  final double? height;
  final double raduis;
  final double padding;
  final Widget? child;
  final Color backgroungColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: backgroungColor,
      ),
      child: child,
    );
  }
}
