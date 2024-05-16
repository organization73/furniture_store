import 'package:flutter/material.dart';

import 'package:decordash/utils/constants/sizes.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
    ),
 
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
    ),

  );
}
