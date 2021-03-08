import 'package:flutter/material.dart';

class ColorPallete {
  Color? primaryColor;
  Color? accentColor;
  Color? monochromaticColor;

  Color? white;
  Color? black;
  Color? red;
  Color? blue;
  Color? green;
  Color? transparent;
  Color? weekEnd;
  Color? darkGrey;
  Color? darkGrey12;
  Color? darkGrey26;
  Color? darkGrey38;
  Color? darkGrey45;
  Color? darkGrey54;
  Color? darkGrey87;
  Color? darkGreyAccent;
  Color? darkGreyAccent2;
  Color? darkGreyAccent3;
  Color? darkGreyAccent4;
  Color? grey;
  Color? greyTransparent;
  Color? backgroundColor;
  Color? backgroundColor1;
  Color? backgroundColor2;
  Color? backgroundColor3;
  Color? backgroundColor4;
  Color? backgroundColor5;
  Color? backgroundDarkColor;
  Color? accentDarkColor;
  Color? onboardingColor1;
  Color? onboardingColor2;
  Color? onboardingColor3;

  ColorPallete({
    this.primaryColor,
    this.accentColor,
    this.monochromaticColor,
    this.white,
    this.black,
    this.red,
    this.blue,
    this.green,
    this.transparent,
    this.weekEnd,
    this.darkGrey,
    this.darkGrey12,
    this.darkGrey26,
    this.darkGrey38,
    this.darkGrey45,
    this.darkGrey54,
    this.darkGrey87,
    this.darkGreyAccent,
    this.darkGreyAccent2,
    this.darkGreyAccent3,
    this.darkGreyAccent4,
    this.grey,
    this.greyTransparent,
    this.backgroundColor,
    this.backgroundColor1,
    this.backgroundColor2,
    this.backgroundColor3,
    this.backgroundColor4,
    this.backgroundColor5,
    this.backgroundDarkColor,
    this.accentDarkColor,
    this.onboardingColor1,
    this.onboardingColor2,
    this.onboardingColor3,
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
    Color? white,
    Color? black,
    Color? red,
    Color? blue,
    Color? green,
    Color? transparent,
    Color? weekEnd,
    Color? darkGrey,
    Color? darkGrey12,
    Color? darkGrey26,
    Color? darkGrey38,
    Color? darkGrey45,
    Color? darkGrey54,
    Color? darkGrey87,
    Color? darkGreyAccent,
    Color? darkGreyAccent2,
    Color? darkGreyAccent3,
    Color? darkGreyAccent4,
    Color? grey,
    Color? greyTransparent,
    Color? backgroundColor,
    Color? backgroundColor1,
    Color? backgroundColor2,
    Color? backgroundColor3,
    Color? backgroundColor4,
    Color? backgroundColor5,
    Color? backgroundDarkColor,
    Color? accentDarkColor,
    Color? onboardingColor1,
    Color? onboardingColor2,
    Color? onboardingColor3,
  }) {
    this.primaryColor = primaryColor ?? const Color(0xFF3A86FF);
    this.accentColor = accentColor ?? const Color(0xFFFFB33A);
    this.monochromaticColor = monochromaticColor ?? const Color(0xFFFFFFFF);
    this.white = white ?? const Color(0xFFFFFFFF);
    this.black = black ?? const Color(0xFF222831);
    this.red = red ?? const Color(0xFFd63447);
    this.blue = blue ?? const Color(0xFF1b6ca8);
    this.green = green ?? const Color(0xFF21bf73);
    this.transparent = transparent ?? const Color(0x00000000);
    this.weekEnd = weekEnd ?? const Color(0xFFf0134d);
    this.darkGrey = darkGrey ?? const Color(0xFF121212);
    this.darkGrey12 = darkGrey12 ?? const Color(0xFF121212).withOpacity(.12);
    this.darkGrey26 = darkGrey26 ?? const Color(0xFF121212).withOpacity(.26);
    this.darkGrey38 = darkGrey38 ?? const Color(0xFF121212).withOpacity(.38);
    this.darkGrey45 = darkGrey45 ?? const Color(0xFF121212).withOpacity(.45);
    this.darkGrey54 = darkGrey54 ?? const Color(0xFF121212).withOpacity(.54);
    this.darkGrey87 = darkGrey87 ?? const Color(0xFF121212).withOpacity(.87);
    this.darkGreyAccent = darkGreyAccent ?? const Color(0xFF222831);
    this.darkGreyAccent2 = darkGreyAccent2 ?? const Color(0xFF525252);
    this.darkGreyAccent3 = darkGreyAccent3 ?? const Color(0xFF414141);
    this.darkGreyAccent4 = darkGreyAccent4 ?? const Color(0xFF313131);
    this.grey = grey ?? const Color(0xFF969696);
    this.greyTransparent = greyTransparent ?? const Color(0xFF969696);
    this.backgroundColor = backgroundColor ?? const Color(0xFFf9f9f9);
    this.backgroundColor1 = backgroundColor1 ?? const Color(0xFFfcfefe);
    this.backgroundColor2 = backgroundColor2 ?? const Color(0xFFF8FCFF);
    this.backgroundColor3 = backgroundColor3 ?? const Color(0xFFf6f6f6);
    this.backgroundColor4 = backgroundColor4 ?? const Color(0xFFfbfbfb);
    this.backgroundColor5 = backgroundColor5 ?? const Color(0xFFf2f2f2);
    this.backgroundDarkColor = backgroundDarkColor ?? const Color(0xFF003545);
    this.accentDarkColor = accentDarkColor ?? const Color(0xFFf638dc);
    this.onboardingColor1 = onboardingColor1 ?? const Color(0xFF82B832);
    this.onboardingColor2 = onboardingColor2 ?? const Color(0xFFB83282);
    this.onboardingColor3 = onboardingColor3 ?? const Color(0xFF3282B8);
  }
}

final colorPallete = ColorPallete();
