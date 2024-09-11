import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/utils/constants/sizes.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData? iconName;
  final CrossAxisAlignment alignment;
  final double size;
  final TextAlign align;

  const PageHeader({
    super.key,
    required this.title,
    required this.subTitle,
    this.iconName,
    this.alignment = CrossAxisAlignment.start,
    this.size = 45,
    this.align = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (iconName != null)
          Icon(
            iconName,
            size: size,
          ),
        const SizedBox(height: TSizes.spaceBtwSections * 1.5),
        Text(
          title,
          textAlign: align,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: TDeviceUtils.getScreenHeight() * 0.02),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: TSizes.spaceBtwSections * 2),
      ],
    );
  }
}
