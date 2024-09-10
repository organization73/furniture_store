import 'package:decordashapp/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/utils/constants/sizes.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData? iconName;
  final CrossAxisAlignment alignment;
  final double size;

  const PageHeader({
    super.key,
    required this.title,
    required this.subTitle,
    this.iconName,
    this.alignment = CrossAxisAlignment.start,
    this.size = 45,
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
          style: Theme.of(context)
              .textTheme
              .headlineSmall
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
