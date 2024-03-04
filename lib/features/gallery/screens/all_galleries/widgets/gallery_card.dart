import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/styles/shadows.dart';
import 'package:furniture_store/features/gallery/model/property.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:furniture_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class GalleryCard extends StatelessWidget {
  final Gallery gallery;
  const GalleryCard({super.key, required this.gallery});
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
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        gallery.imagePath,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: -15.0,
                    left: 10.0,
                    child: CircleAvatar(
                      radius: 30,
                      child: CachedNetworkImage(
                        imageUrl: 'https://picsum.photos/id/80/80/80',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person),
                      ),
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
                      child: Text(gallery.name,
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(gallery.description,
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
                      gallery.address,
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
