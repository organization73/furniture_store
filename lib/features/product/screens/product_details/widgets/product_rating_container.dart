import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/overlapping_cicular_avatar.dart';
import 'package:furniture_store/global/global_variables.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
        height: 70.h,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isDark ? TColors.darkerGrey : TColors.light,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Iconsax.star5,
                                color: Colors.amber,
                                size: TSizes.iconMd,
                              ),
                              SizedBox(
                                width: TSizes.spaceBtwItems / 2,
                              ),
                              Text('5.0',
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${22} reviews',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ]),
            ),
            Expanded(
              flex: 1,
              child: OverlappingCircularAvatar(
                product: allProductsList[1],
              ),
            ),
          ],
        ));
  }
}
