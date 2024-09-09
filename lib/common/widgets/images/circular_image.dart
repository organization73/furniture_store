import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';

import 'package:decordashapp/utils/constants/sizes.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.imageUrl,
    this.isNetworkImage = false,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
  });

  final BoxFit? fit;
  final String imageUrl;
  final bool isNetworkImage;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: fit,
                  progressIndicatorBuilder: (context, url, progress) =>
                      ShimmerLoaderEffect(
                    width: width,
                    height: height,
                    raduis: 55,
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    size: TSizes.iconLg,
                  ),
                )
              : Image(
                  fit: fit,
                  image: isNetworkImage
                      ? NetworkImage(imageUrl)
                      : AssetImage(imageUrl) as ImageProvider,
                ),
        ),
      ),
    );
  }
}
