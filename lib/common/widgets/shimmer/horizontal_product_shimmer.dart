import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HorizontalProductShimmer extends StatelessWidget {
  const HorizontalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwSections),
      height: 115,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShimmerLoaderEffect(width: 120, height: 120),
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
                      ShimmerLoaderEffect(width: 160, height: 15),
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      ShimmerLoaderEffect(width: 110, height: 15),
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      ShimmerLoaderEffect(width: 80, height: 15),
                      Spacer()
                    ],
                  )
                ],
              ),
          separatorBuilder: (context, index) =>
              const SizedBox(width: TSizes.spaceBtwItems),
          itemCount: itemCount),
    );
  }
}
