import 'package:decordash/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BoxesShimmer extends StatelessWidget {
  const BoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: ShimmerLoaderEffect(width: 150, height: 110),
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            const Expanded(
              child: ShimmerLoaderEffect(width: 150, height: 110),
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            const Expanded(
              child: ShimmerLoaderEffect(width: 150, height: 110),
            ),
          ],
        )
      ],
    );
  }
}
