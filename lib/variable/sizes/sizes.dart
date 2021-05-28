import 'package:flutter/material.dart';

enum TypeLayout { mobile, largeMobile, tablet, laptop, desktop }

class SizesDevice {
  double get mobileBreakPoint => 576;
  double get largeMobileBreakPoint => 768;
  double get tabletBreakPoint => 992;
  double get laptopBreakPoint => 1200;
  double get pcBreakPoint => 1400;

  MediaQueryData mediaQuery(BuildContext context) => MediaQuery.of(context);

  double width(BuildContext context) => MediaQuery.of(context).size.width;

  double height(BuildContext context) => MediaQuery.of(context).size.height;

  double statusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;

  double screenHeightMinusAppBar(BuildContext context) => sizes.height(context) - kToolbarHeight;

  double screenHeightMinusStatusBar(BuildContext context) =>
      sizes.height(context) - statusBarHeight(context);

  double screenHeightMinusAppBarAndStatusBar(BuildContext context) =>
      sizes.height(context) - kToolbarHeight - statusBarHeight(context);

  double keyboardHeight(BuildContext context) => MediaQuery.of(context).viewInsets.bottom;

  MediaQueryData smallestDimension(BuildContext context) =>
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

  /// Check if devices reach mobile breakpoint
  bool isMobileBreakPoint(BuildContext context) =>
      smallestDimension(context).size.shortestSide <= mobileBreakPoint;

  /// Check if devices reach large mobile breakpoint
  bool isLargeMobileBreakPoint(BuildContext context) =>
      smallestDimension(context).size.shortestSide <= largeMobileBreakPoint;

  /// Check if devices reach Tablet breakpoint
  bool isTabletBreakPoint(BuildContext context) =>
      smallestDimension(context).size.shortestSide <= tabletBreakPoint;

  /// Check if devices reach Laptop breakpoint
  bool isLaptopBreakPoint(BuildContext context) =>
      smallestDimension(context).size.shortestSide <= laptopBreakPoint;

  /// Check if devices reach PC breakpoint
  bool isPCBreakPoint(BuildContext context) =>
      smallestDimension(context).size.shortestSide <= pcBreakPoint;

  double responsiveSize(BuildContext context) => width(context) / 100;

  double dp4(BuildContext context) => MediaQuery.of(context).size.width / 100;
  double dp6(BuildContext context) => MediaQuery.of(context).size.width / 70;
  double dp8(BuildContext context) => MediaQuery.of(context).size.width / 54;
  double dp10(BuildContext context) => MediaQuery.of(context).size.width / 41;
  double dp12(BuildContext context) => MediaQuery.of(context).size.width / 34;
  double dp14(BuildContext context) => MediaQuery.of(context).size.width / 29;
  double dp16(BuildContext context) => MediaQuery.of(context).size.width / 26;
  double dp18(BuildContext context) => MediaQuery.of(context).size.width / 23;
  double dp20(BuildContext context) => MediaQuery.of(context).size.width / 20;
  double dp22(BuildContext context) => MediaQuery.of(context).size.width / 17;
  double dp24(BuildContext context) => MediaQuery.of(context).size.width / 16;
  double dp25(BuildContext context) => MediaQuery.of(context).size.width / 15;
}

final sizes = SizesDevice();
