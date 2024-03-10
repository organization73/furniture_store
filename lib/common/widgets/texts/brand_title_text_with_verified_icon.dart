import 'package:flutter/cupertino.dart';
import 'package:decordash/common/widgets/texts/brand_title_text.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/constants/enums.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BrandTitleTextWithVerifiedIcon extends StatelessWidget {
  const BrandTitleTextWithVerifiedIcon(
      {super.key,
      required this.title,
      this.maxLines = 1,
      this.textColor,
      this.iconColor = TColors.primary,
      this.textAlign = TextAlign.center,
      this.beandtextSize = TextSizes.small});

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes beandtextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
            child: BrandTitleText(
          title: title,
          color: textColor,
          maxLines: maxLines,
          textAlign: textAlign,
          brandtextSize: beandtextSize,
        )),
        const SizedBox(
          width: TSizes.xs,
        ),
        Icon(
          Iconsax.verify,
          color: iconColor,
          size: TSizes.iconSm,
        )
      ],
    );
  }
}
