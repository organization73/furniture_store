import 'package:decordash/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalProductShimmer extends StatelessWidget {
  const HorizontalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: TSizes.spaceBtwSections),
      height: 115.r,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShimmerLoaderEffect(width: 120.r, height: 120.r),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      ShimmerLoaderEffect(width: 160.w, height: 15.h),
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      ShimmerLoaderEffect(width: 110.w, height: 15.h),
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      ShimmerLoaderEffect(width: 80.w, height: 15.h),
                      const Spacer()
                    ],
                  )
                ],
              ),
          separatorBuilder: (context, index) =>
              SizedBox(width: TSizes.spaceBtwItems),
          itemCount: itemCount),
    );
  }
}
