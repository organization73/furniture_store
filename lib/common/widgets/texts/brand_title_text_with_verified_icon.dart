import 'package:decordashapp/features/home/model/vendor_model.dart';
import 'package:decordashapp/common/widgets/texts/brand_title_text.dart';

import 'package:decordashapp/utils/constants/enums.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BrandTitleTextWithVerifiedIcon extends StatelessWidget {
  const BrandTitleTextWithVerifiedIcon(
      {super.key,
      required this.vendor,
      this.maxLines = 1,
      this.textColor,
      this.iconColor = Colors.blue,
      this.textAlign = TextAlign.center,
      this.title,
      this.beandtextSize = TextSizes.small});

  final VendorModel vendor;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes beandtextSize;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
            child: BrandTitleText(
          title: vendor.name,
          color: textColor,
          maxLines: maxLines,
          textAlign: textAlign,
          brandtextSize: beandtextSize,
        )),
        const SizedBox(
          width: TSizes.xs,
        ),
        if (vendor.isVerified ?? false)
          Icon(
            Iconsax.verify,
            color: iconColor,
            size: TSizes.iconSm,
          )
      ],
    );
  }
}
