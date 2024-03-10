import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/constants/sizes.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static final lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: TColors.white,
    iconTheme: const IconThemeData(color: TColors.black, size: TSizes.iconMd),
    actionsIconTheme:
        const IconThemeData(color: TColors.black, size: TSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 14.0.sp, fontWeight: FontWeight.w500, color: TColors.black),
  );
  static final darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: TColors.black,
    iconTheme: const IconThemeData(color: TColors.white, size: TSizes.iconMd),
    actionsIconTheme:
        const IconThemeData(color: TColors.white, size: TSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 14.0.sp, fontWeight: FontWeight.w500, color: TColors.white),
  );
}
