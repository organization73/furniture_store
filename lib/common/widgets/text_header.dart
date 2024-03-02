import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/utils/constants/colors.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

class BuildTopText extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData? iconName;
  final CrossAxisAlignment alignment;
  final double size;

  const BuildTopText({
    super.key,
    required this.title,
    required this.subTitle,
    this.iconName,
    this.alignment = CrossAxisAlignment.start,
    this.size = 40,
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
            color: TColors.grey,
          ),
        SizedBox(height: TSizes.spaceBtwSections),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: 15.h),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: TSizes.spaceBtwSections * 2),
      ],
    );
  }
}
