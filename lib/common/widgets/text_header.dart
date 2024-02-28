import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildTopText extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? iconName;
  final CrossAxisAlignment alignment;

  const BuildTopText({
    super.key,
    required this.title,
    required this.subTitle,
    this.iconName,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (iconName != null) SvgPicture.asset('assets/icons/$iconName.svg'),
        SizedBox(
          height: 20.h,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: 15.h),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
