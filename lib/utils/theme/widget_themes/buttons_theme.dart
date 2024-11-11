import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ButtonsTheme {
  ButtonsTheme._();

  static final filledButtonTheme = _buildFilledButtonTheme();
  static final outlinedButtonTheme = _buildOutlinedButtonTheme();
  static final elevatedButtonTheme = _buildElevatedButtonTheme();

  static FilledButtonThemeData _buildFilledButtonTheme() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        ),
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        side: const BorderSide(),
        padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius),
        ),
      ),
    );
  }
}
