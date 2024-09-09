import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BoxesShimmer extends StatelessWidget {
  const BoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ShimmerLoaderEffect(width: 150, height: 110),
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Expanded(
              child: ShimmerLoaderEffect(width: 150, height: 110),
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Expanded(
              child: ShimmerLoaderEffect(width: 150, height: 110),
            ),
          ],
        )
      ],
    );
  }
}
