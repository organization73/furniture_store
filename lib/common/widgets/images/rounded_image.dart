import 'package:flutter/material.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage(
      {super.key,
      this.width,
      this.height,
      required this.imageUrl,
      this.applyImageRaduis = true,
      this.border,
      this.backgroundColor,
      this.fit = BoxFit.contain,
      this.padding,
      this.isNetworkImage = false,
      this.onPress,
      this.borderRaduis = TSizes.md});
  final double? width;
  final double? height;
  final String imageUrl;
  final bool applyImageRaduis;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPress;
  final double borderRaduis;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRaduis)),
        child: ClipRRect(
          borderRadius: applyImageRaduis
              ? BorderRadius.circular(borderRaduis)
              : BorderRadius.zero,
          child: Image(
              fit: fit,
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider),
        ),
      ),
    );
  }
}
