import 'package:flutter/material.dart';
import 'package:decordashapp/utils/constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      // textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(
          vertical: TSizes.buttonHeight),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
    ),
  );
}
