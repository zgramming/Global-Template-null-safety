import 'package:flutter/material.dart';

class ColorPallete {
  Color? primaryColor;
  Color? accentColor;
  Color? monochromaticColor;
  Color? transparent;
  Color? onboardingColor1;
  Color? onboardingColor2;
  Color? onboardingColor3;

  /// Color For Success , identic with green
  Color? success;

  /// Color For Error , identic with red
  Color? error;

  /// Color For Info , identic with blue
  Color? info;

  /// Color For Warning , identic with orange / yellow
  Color? warning;

  ColorPallete({
    this.primaryColor = const Color(0xFF3A86FF),
    this.accentColor = const Color(0xFFFFB33A),
    this.monochromaticColor = const Color(0xFFFFFFFF),
    this.transparent = const Color(0x00000000),
    this.onboardingColor1 = const Color(0xFF82B832),
    this.onboardingColor2 = const Color(0xFFB83282),
    this.onboardingColor3 = const Color(0xFF3282B8),
    this.success = const Color(0xFF28df99),
    this.error = const Color(0xFFe40017),
    this.info = const Color(0xFF51c2d5),
    this.warning = const Color(0xFFf48b29),
  });

  List<Color> arrColor = [
    const Color(0xFFfb5607),
    const Color(0xFFff006e),
    const Color(0xFF8338ec),
    const Color(0xFF3a86ff),
    const Color(0xFFe07a5f),
    const Color(0xFF3d405b),
    const Color(0xFF118ab2),
    const Color(0xFF3d5a80),
    const Color(0xFF50514f),
    const Color(0xFFf25f5c),
    const Color(0xFF247ba0),
    const Color(0xFFf07167),
  ];

  /// Visit this link if you want get generate nice color [https://mycolor.space/]
  void configuration({
    Color? primaryColor,
    Color? accentColor,
    Color? monochromaticColor,
    Color? transparent,
    Color? onboardingColor1,
    Color? onboardingColor2,
    Color? onboardingColor3,

    /// Color For Success , identic with green
    Color? success,

    /// Color For Error , identic with red
    Color? error,

    /// Color For Info , identic with blue
    Color? info,

    /// Color For Warning , identic with orange / yellow
    Color? warning,
  }) {
    this.primaryColor = primaryColor;
    this.accentColor = accentColor;
    this.monochromaticColor = monochromaticColor;
    this.transparent = transparent;
    this.onboardingColor1 = onboardingColor1;
    this.onboardingColor2 = onboardingColor2;
    this.onboardingColor3 = onboardingColor3;
    this.success = success;
    this.error = error;
    this.info = info;
    this.warning = warning;
  }
}

final colorPallete = ColorPallete();
