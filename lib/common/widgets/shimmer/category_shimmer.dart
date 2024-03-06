import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/shimmer/shimmer_loader.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoaderEffect(
                width: 125,
                height: 56,
                raduis: 8,
              )
            ],
          );
        },
      ),
    );
  }
}
