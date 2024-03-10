import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/styles/shadows.dart';
import 'package:decordash/common/widgets/images/circular_image.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/helper_functions.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GalleryCard extends StatelessWidget {
  const GalleryCard({super.key, required this.vendor});
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [ShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.white,
      ),
      height: 250.h,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(TSizes.productImageRadius),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/galleries/property-1.png',
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: -15.0,
                    left: 10.0,
                    child: CircularImage(
                      imageUrl: vendor.image,
                      isNetworkImage: true,
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(vendor.name,
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text('vendor.description',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Icon(
                      Iconsax.location,
                      size: TSizes.iconSm,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      vendor.location,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
