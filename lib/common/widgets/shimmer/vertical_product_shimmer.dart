import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/layouts/grid_layout.dart';
import 'package:decordash/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordash/utils/constants/sizes.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => SizedBox(
              width: 100,
              child: Column(
                children: [
                  const ShimmerLoaderEffect(width: 180, height: 180),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const ShimmerLoaderEffect(width: 160, height: 15),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  const ShimmerLoaderEffect(width: 110, height: 15),
                ],
              ),
            ));
  }
}
