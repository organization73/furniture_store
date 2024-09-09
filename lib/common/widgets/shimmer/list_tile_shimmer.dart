import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            ShimmerLoaderEffect(
              width: 50,
              height: 50,
              raduis: 50,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Column(
              children: [
                ShimmerLoaderEffect(width: 100, height: 15),
                SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                ShimmerLoaderEffect(width: 80, height: 12)
              ],
            )
          ],
        )
      ],
    );
  }
}
