import 'package:flutter/material.dart';
import 'package:decordashapp/utils/constants/sizes.dart';

/// Custom Class for Light & Dark Text Themes
class TCheckboxTheme {
  TCheckboxTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    visualDensity: VisualDensity.compact,
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.xs)),
  );
}
