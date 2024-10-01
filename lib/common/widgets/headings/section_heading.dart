import 'package:flutter/material.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    this.showSubTitle = false,
    required this.title,
    this.buttonTitle,
    this.onPress,
    this.subTitle = '',
  });

  final Color? textColor;
  final bool showActionButton;
  final bool showSubTitle;
  final String title;
  final String? buttonTitle;
  final String subTitle;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final localizedButtonTitle = buttonTitle?.tr ?? 'viewAll'.tr;

    final textDirection = Directionality.of(context);

    return Directionality(
      textDirection: textDirection,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: textColor)),
              if (showSubTitle)
                Column(
                  children: [
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    Text(
                      subTitle,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                  ],
                ),
            ],
          ),
          if (showActionButton)
            TextButton(
              onPressed: onPress,
              child: Row(
                children: [
                  Text(
                    localizedButtonTitle,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    width: TSizes.sm,
                  ),
                  Icon(
                    textDirection == TextDirection.ltr
                        ? IconsaxPlusLinear.arrow_right_3
                        : IconsaxPlusLinear.arrow_left_2,
                    size: TSizes.iconSm,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
