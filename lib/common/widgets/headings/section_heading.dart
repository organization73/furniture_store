import 'package:flutter/material.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    required this.title,
    this.buttonTitle,
    this.onPress,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title;
  final String?
      buttonTitle;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final localizedButtonTitle = buttonTitle?.tr ?? 'viewAll'.tr;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:
              Theme.of(context).textTheme.titleLarge!.apply(color: textColor),
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPress,
            child: Row(
              children: [
                Text(
                  localizedButtonTitle,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: TSizes.sm,
                ),
                const Icon(
                  Iconsax.arrow_right_1,
                  size: TSizes.iconSm,
                ),
              ],
            ),
          )
      ],
    );
  }
}
