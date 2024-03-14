import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/features/product/screens/product_details/widgets/overlapping_cicular_avatar.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/helper_functions.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
        height: 73.h,
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
                                Iconsax.star,
                                color: Colors.amber,
                                size: TSizes.iconMd,
                              ),
                              SizedBox(
                                width: TSizes.spaceBtwItems / 2,
                              ),
                              Text(product.productRating.toStringAsFixed(1),
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${product.productNumOfRating} reviews',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ]),
            ),
            Expanded(
              flex: 1,
              child: OverlappingCircularAvatar(
                product: product,
              ),
            ),
          ],
        ));
  }
}
