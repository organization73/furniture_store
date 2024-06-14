import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/layouts/grid_layout.dart';
import 'package:decordash/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoaderEffect(width: 185.r, height: 140.r),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ShimmerLoaderEffect(width: 165.r, height: 20.r),
                SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                ShimmerLoaderEffect(width: 115.r, height: 20.r),
              ],
            ));
  }
}
