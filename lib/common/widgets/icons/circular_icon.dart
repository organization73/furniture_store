import 'package:flutter/material.dart';

import 'package:decordash/utils/constants/sizes.dart';

class CicularIcon extends StatelessWidget {
  const CicularIcon({
    super.key,
    this.width,
    this.height,
    this.size,
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
          color: backgrounfColor ??
              Theme.of(context).colorScheme.surfaceContainer),
      child: IconButton(
          onPressed: onPress,
          icon: Icon(
            icon,
            color: color,
            size: size ?? TSizes.iconMd,
          )),
    );
  }
}
