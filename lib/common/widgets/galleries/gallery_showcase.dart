import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordash/common/widgets/galleries/featured_gallery_card.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/helper_functions.dart';

class GelleryShowCase extends StatelessWidget {
  const GelleryShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(TSizes.sm),
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          //TODO:fix this empty
          FeaturedGalleryCard(
            showBorder: false,
            vendor: VendorModel.empty(),
          ),
          const SizedBox(
            height: TSizes.sm,
          ),
          Row(
              children: images
                  .map((image) => galleryTopProductsWidget(image, context))
                  .toList())
        ],
      ),
    );
  }

  Widget galleryTopProductsWidget(String image, context) {
    return Expanded(
      child: RoundedContainer(
        hight: 100,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.light,
        margin: const EdgeInsets.only(right: TSizes.sm),
        padding: const EdgeInsets.all(TSizes.md),
        child: Image(fit: BoxFit.contain, image: AssetImage(image)),
      ),
    );
  }
}
