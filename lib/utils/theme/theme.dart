import "package:decordashapp/utils/theme/widget_themes/buttons_theme.dart";
import "package:decordashapp/utils/theme/widget_themes/checkbox_theme.dart";
import "package:decordashapp/utils/theme/widget_themes/text_field_theme.dart";
import "package:decordashapp/utils/theme/widget_themes/text_theme.dart";
import "package:flutter/material.dart";

class MaterialTheme {
  const MaterialTheme();

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff445e91),
      surfaceTint: Color(0xff445e91),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd8e2ff),
      onPrimaryContainer: Color(0xff001a41),
      secondary: Color(0xff565e71),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdbe2f9),
      onSecondaryContainer: Color(0xff141b2c),
      tertiary: Color(0xff445e91),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd8e2ff),
      onTertiaryContainer: Color(0xff001a41),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1b20),
      onSurfaceVariant: Color(0xff44474f),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc4c6d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff2b4678),
      secondaryFixed: Color(0xffdbe2f9),
      onSecondaryFixed: Color(0xff141b2c),
      secondaryFixedDim: Color(0xffbfc6dc),
      onSecondaryFixedVariant: Color(0xff3f4759),
      tertiaryFixed: Color(0xffd8e2ff),
      onTertiaryFixed: Color(0xff001a41),
      tertiaryFixedDim: Color(0xffadc6ff),
      onTertiaryFixedVariant: Color(0xff2b4678),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe8e7ee),
      surfaceContainerHighest: Color(0xffe2e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadc6ff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff102f60),
      primaryContainer: Color(0xff2b4678),
      onPrimaryContainer: Color(0xffd8e2ff),
      secondary: Color(0xffbfc6dc),
      onSecondary: Color(0xff293041),
      secondaryContainer: Color(0xff3f4759),
      onSecondaryContainer: Color(0xffdbe2f9),
      tertiary: Color(0xffadc6ff),
      onTertiary: Color(0xff102f60),
      tertiaryContainer: Color(0xff2b4678),
      onTertiaryContainer: Color(0xffd8e2ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111318),
      onSurface: Color(0xffe2e2e9),
      onSurfaceVariant: Color(0xffc4c6d0),
      outline: Color(0xff8e9099),
      outlineVariant: Color(0xff44474f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e9),
      inversePrimary: Color(0xff445e91),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a41),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff2b4678),
      secondaryFixed: Color(0xffdbe2f9),
      onSecondaryFixed: Color(0xff141b2c),
      secondaryFixedDim: Color(0xffbfc6dc),
      onSecondaryFixedVariant: Color(0xff3f4759),
      tertiaryFixed: Color(0xffd8e2ff),
      onTertiaryFixed: Color(0xff001a41),
      tertiaryFixedDim: Color(0xffadc6ff),
      onTertiaryFixedVariant: Color(0xff2b4678),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff1a1b20),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: TTextTheme.lightTextTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
        elevatedButtonTheme: ButtonsTheme.elevatedButtonTheme,
        outlinedButtonTheme: ButtonsTheme.outlinedButtonTheme,
        filledButtonTheme: ButtonsTheme.filledButtonTheme,
        inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
      );
}
