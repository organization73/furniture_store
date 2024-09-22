import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/layouts/grid_layout.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/utils/constants/sizes.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoaderEffect(width: 185, height: 140),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ShimmerLoaderEffect(width: 165, height: 20),
                SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                ShimmerLoaderEffect(width: 115, height: 20),
              ],
            ));
  }
}
