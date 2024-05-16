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
                ShimmerLoaderEffect(width: 180.w, height: 150.h),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ShimmerLoaderEffect(width: 160.w, height: 15.h),
                SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                ShimmerLoaderEffect(width: 110.w, height: 15.h),
              ],
            ));
  }
}
