import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordash/utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        itemBuilder: (_, __) {
          return Column(
            children: [
              ShimmerLoaderEffect(
                width: 125.w,
                height: 55.h,
                raduis: 8.r,
              ),
            ],
          );
        },
      ),
    );
  }
}
