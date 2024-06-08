import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff715188),
      surfaceTint: Color(0xff715188),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc295e0),
      onPrimaryContainer: Color(0xff2a0c40),
      secondary: Color(0xff715188),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff2daff),
      onSecondaryContainer: Color(0xff2a0c40),
      tertiary: Color(0xff715188),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcc9fe1),
      onTertiaryContainer: Color(0xff2a0c40),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xffdeb8f7),
      onBackground: Color(0xff1e1a20),
      surface: Color(0xffdeb8f7),
      onSurface: Color(0xff1e1a20),
      surfaceVariant: Color(0xffC9A0DC),
      onSurfaceVariant: Color(0xff4b454d),
      outline: Color(0xff7c757e),
      outlineVariant: Color(0xffcdc3ce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff332f35),
      inverseOnSurface: Color(0xfff7eef6),
      inversePrimary: Color(0xffdeb8f7),
      primaryFixed: Color(0xfff2daff),
      onPrimaryFixed: Color(0xff2a0c40),
      primaryFixedDim: Color(0xffdeb8f7),
      onPrimaryFixedVariant: Color(0xff583a6f),
      secondaryFixed: Color(0xfff2daff),
      onSecondaryFixed: Color(0xff2a0c40),
      secondaryFixedDim: Color(0xffdeb8f7),
      onSecondaryFixedVariant: Color(0xff583a6f),
      tertiaryFixed: Color(0xfff2daff),
      onTertiaryFixed: Color(0xff2a0c40),
      tertiaryFixedDim: Color(0xffdeb8f7),
      onTertiaryFixedVariant: Color(0xff583a6f),
      surfaceDim: Color(0xffe0d7df),
      surfaceBright: Color(0xfffff7fd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffaf1f9),
      surfaceContainer: Color(0xfff4ebf3),
      surfaceContainerHigh: Color(0xffeee6ed),
      surfaceContainerHighest: Color(0xffC9A0DC),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdeb8f7),
      surfaceTint: Color(0xffdeb8f7),
      onPrimary: Color(0xff402357),
      primaryContainer: Color(0xff221e24),
      onPrimaryContainer: Color(0xfff2daff),
      secondary: Color(0xffdeb8f7),
      onSecondary: Color(0xff402357),
      secondaryContainer: Color(0xff3c383e),
      onSecondaryContainer: Color(0xfff2daff),
      tertiary: Color(0xffdeb8f7),
      onTertiary: Color(0xff402357),
      tertiaryContainer: Color(0xff221e24), //0xff262626
      onTertiaryContainer: Color(0xfff2daff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff161217),
      onBackground: Color(0xffe8e0e8),
      surface: Color(0xff161217),
      onSurface: Color(0xffe8e0e8),
      surfaceVariant: Color(0xff4b454d),
      onSurfaceVariant: Color(0xffcdc3ce),
      outline: Color(0xff968e98),
      outlineVariant: Color(0xff4b454d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e0e8),
      inverseOnSurface: Color(0xff332f35),
      inversePrimary: Color(0xff161217),
      primaryFixed: Color(0xfff2daff),
      onPrimaryFixed: Color(0xff2a0c40),
      primaryFixedDim: Color(0xffdeb8f7),
      onPrimaryFixedVariant: Color(0xff583a6f),
      secondaryFixed: Color(0xfff2daff),
      onSecondaryFixed: Color(0xff2a0c40),
      secondaryFixedDim: Color(0xffdeb8f7),
      onSecondaryFixedVariant: Color(0xff583a6f),
      tertiaryFixed: Color(0xfff2daff),
      onTertiaryFixed: Color(0xff2a0c40),
      tertiaryFixedDim: Color(0xffdeb8f7),
      onTertiaryFixedVariant: Color(0xff583a6f),
      surfaceDim: Color(0xff161217),
      surfaceBright: Color(0xff3c383e),
      surfaceContainerLowest: Color(0xff100d12),
      surfaceContainerLow: Color(0xff1e1a20),
      surfaceContainer: Color(0xff221e24),
      surfaceContainerHigh: Color(0xff2d292e),
      surfaceContainerHighest: Color(0xff4b454d),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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
