import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff37693d),
      surfaceTint: Color(0xff37693d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb8f0b8),
      onPrimaryContainer: Color(0xff1e5027),
      secondary: Color(0xff426833),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffc3efad),
      onSecondaryContainer: Color(0xff2b4f1e),
      tertiary: Color(0xff5e621b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe4e892),
      onTertiaryContainer: Color(0xff474a02),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff7fbf2),
      onSurface: Color(0xff181d18),
      onSurfaceVariant: Color(0xff424940),
      outline: Color(0xff727970),
      outlineVariant: Color(0xffc1c9be),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xff9dd49e),
      primaryFixed: Color(0xffb8f0b8),
      onPrimaryFixed: Color(0xff002107),
      primaryFixedDim: Color(0xff9dd49e),
      onPrimaryFixedVariant: Color(0xff1e5027),
      secondaryFixed: Color(0xffc3efad),
      onSecondaryFixed: Color(0xff042100),
      secondaryFixedDim: Color(0xffa8d293),
      onSecondaryFixedVariant: Color(0xff2b4f1e),
      tertiaryFixed: Color(0xffe4e892),
      onTertiaryFixed: Color(0xff1b1d00),
      tertiaryFixedDim: Color(0xffc8cc78),
      onTertiaryFixedVariant: Color(0xff474a02),
      surfaceDim: Color(0xffd7dbd3),
      surfaceBright: Color(0xfff7fbf2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffebefe6),
      surfaceContainerHigh: Color(0xffe5e9e1),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0a3f18),
      surfaceTint: Color(0xff37693d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff46784a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1b3e0e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff517741),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff363900),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6d7128),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf2),
      onSurface: Color(0xff0e120d),
      onSurfaceVariant: Color(0xff313830),
      outline: Color(0xff4d544c),
      outlineVariant: Color(0xff686f66),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xff9dd49e),
      primaryFixed: Color(0xff46784a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff2d5f34),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff517741),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff395e2b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6d7128),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff555811),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c8c0),
      surfaceBright: Color(0xfff7fbf2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffe5e9e1),
      surfaceContainerHigh: Color(0xffdaded6),
      surfaceContainerHighest: Color(0xffcfd3cb),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003410),
      surfaceTint: Color(0xff37693d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff215329),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff103305),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e5220),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2c2e00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff494d04),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf2),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff272e26),
      outlineVariant: Color(0xff444b43),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xff9dd49e),
      primaryFixed: Color(0xff215329),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff053b15),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2e5220),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff173a0b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff494d04),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff333500),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb6bab2),
      surfaceBright: Color(0xfff7fbf2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeef2e9),
      surfaceContainer: Color(0xffe0e4db),
      surfaceContainerHigh: Color(0xffd2d6cd),
      surfaceContainerHighest: Color(0xffc4c8c0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9dd49e),
      surfaceTint: Color(0xff9dd49e),
      onPrimary: Color(0xff023913),
      primaryContainer: Color(0xff1e5027),
      onPrimaryContainer: Color(0xffb8f0b8),
      secondary: Color(0xffa8d293),
      onSecondary: Color(0xff153809),
      secondaryContainer: Color(0xff2b4f1e),
      onSecondaryContainer: Color(0xffc3efad),
      tertiary: Color(0xffc8cc78),
      onTertiary: Color(0xff303300),
      tertiaryContainer: Color(0xff474a02),
      onTertiaryContainer: Color(0xffe4e892),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101510),
      onSurface: Color(0xffe0e4db),
      onSurfaceVariant: Color(0xffc1c9be),
      outline: Color(0xff8c9389),
      outlineVariant: Color(0xff424940),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff37693d),
      primaryFixed: Color(0xffb8f0b8),
      onPrimaryFixed: Color(0xff002107),
      primaryFixedDim: Color(0xff9dd49e),
      onPrimaryFixedVariant: Color(0xff1e5027),
      secondaryFixed: Color(0xffc3efad),
      onSecondaryFixed: Color(0xff042100),
      secondaryFixedDim: Color(0xffa8d293),
      onSecondaryFixedVariant: Color(0xff2b4f1e),
      tertiaryFixed: Color(0xffe4e892),
      onTertiaryFixed: Color(0xff1b1d00),
      tertiaryFixedDim: Color(0xffc8cc78),
      onTertiaryFixedVariant: Color(0xff474a02),
      surfaceDim: Color(0xff101510),
      surfaceBright: Color(0xff363a35),
      surfaceContainerLowest: Color(0xff0b0f0b),
      surfaceContainerLow: Color(0xff181d18),
      surfaceContainer: Color(0xff1c211c),
      surfaceContainerHigh: Color(0xff272b26),
      surfaceContainerHighest: Color(0xff313630),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb2eab2),
      surfaceTint: Color(0xff9dd49e),
      onPrimary: Color(0xff002d0c),
      primaryContainer: Color(0xff699d6b),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbde9a7),
      onSecondary: Color(0xff092c01),
      secondaryContainer: Color(0xff739b61),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdee28c),
      onTertiary: Color(0xff262800),
      tertiaryContainer: Color(0xff919548),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101510),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd7ded3),
      outline: Color(0xffadb4a9),
      outlineVariant: Color(0xff8b9288),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff205228),
      primaryFixed: Color(0xffb8f0b8),
      onPrimaryFixed: Color(0xff001604),
      primaryFixedDim: Color(0xff9dd49e),
      onPrimaryFixedVariant: Color(0xff0a3f18),
      secondaryFixed: Color(0xffc3efad),
      onSecondaryFixed: Color(0xff021500),
      secondaryFixedDim: Color(0xffa8d293),
      onSecondaryFixedVariant: Color(0xff1b3e0e),
      tertiaryFixed: Color(0xffe4e892),
      onTertiaryFixed: Color(0xff111200),
      tertiaryFixedDim: Color(0xffc8cc78),
      onTertiaryFixedVariant: Color(0xff363900),
      surfaceDim: Color(0xff101510),
      surfaceBright: Color(0xff414640),
      surfaceContainerLowest: Color(0xff050805),
      surfaceContainerLow: Color(0xff1a1f1a),
      surfaceContainer: Color(0xff242924),
      surfaceContainerHigh: Color(0xff2f342e),
      surfaceContainerHighest: Color(0xff3a3f39),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc5fec5),
      surfaceTint: Color(0xff9dd49e),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff99d09a),
      onPrimaryContainer: Color(0xff000f02),
      secondary: Color(0xffd0fdb9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffa4ce8f),
      onSecondaryContainer: Color(0xff010f00),
      tertiary: Color(0xfff2f69e),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc4c875),
      onTertiaryContainer: Color(0xff0b0c00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff101510),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffebf2e6),
      outlineVariant: Color(0xffbec5ba),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff205228),
      primaryFixed: Color(0xffb8f0b8),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff9dd49e),
      onPrimaryFixedVariant: Color(0xff001604),
      secondaryFixed: Color(0xffc3efad),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffa8d293),
      onSecondaryFixedVariant: Color(0xff021500),
      tertiaryFixed: Color(0xffe4e892),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc8cc78),
      onTertiaryFixedVariant: Color(0xff111200),
      surfaceDim: Color(0xff101510),
      surfaceBright: Color(0xff4d514b),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1c211c),
      surfaceContainer: Color(0xff2d322c),
      surfaceContainerHigh: Color(0xff383d37),
      surfaceContainerHighest: Color(0xff434842),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
