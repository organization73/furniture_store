import 'package:decordashapp/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:decordashapp/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:decordashapp/utils/theme/widget_themes/text_field_theme.dart';
import 'package:decordashapp/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF007AFF),
      brightness: Brightness.light,
    ),
    textTheme: TTextTheme.lightTextTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF007AFF), brightness: Brightness.dark),
    textTheme: TTextTheme.darkTextTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
