import 'package:flutter/material.dart';

class AppTheme {
  ThemeData theme(BuildContext context) => Theme.of(context);
  TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;

  ///Used for emphasizing text that would otherwise be [bodyText2].
  TextStyle? bodyText1(BuildContext context) => textTheme(context).bodyLarge;

  ///The default text style for [Material].
  TextStyle? bodyText2(BuildContext context) => textTheme(context).bodyMedium;

  ///Used for text on [ElevatedButton] and [TextButton].
  TextStyle? button(BuildContext context) => textTheme(context).labelLarge;

  ///Used for auxiliary text associated with images.
  TextStyle? caption(BuildContext context) => textTheme(context).bodySmall;

  ///Extremely large text.
  TextStyle? headline1(BuildContext context) => textTheme(context).displayLarge;

  ///Used for the date in the dialog shown by [showDatePicker].
  TextStyle? headline2(BuildContext context) =>
      textTheme(context).displayMedium;

  ///Very large text.
  TextStyle? headline3(BuildContext context) => textTheme(context).displaySmall;

  ///Large text.
  TextStyle? headline4(BuildContext context) =>
      textTheme(context).headlineMedium;

  ///Used for large text in dialogs (e.g., the month and year in the dialog shown by [showDatePicker]).
  TextStyle? headline5(BuildContext context) =>
      textTheme(context).headlineSmall;

  ///Used for the primary text in app bars and dialogs (e.g., [AppBar.title] and [AlertDialog.title]).
  TextStyle? headline6(BuildContext context) => textTheme(context).titleLarge;

  ///The smallest style.
  ///Typically used for captions or to introduce a (larger) headline.
  TextStyle? overline(BuildContext context) => textTheme(context).labelSmall;

  ///Used for the primary text in lists (e.g., [ListTile.title]).
  TextStyle? subtitle1(BuildContext context) => textTheme(context).titleMedium;

  ///For medium emphasis text that's a little smaller than [subtitle1].
  TextStyle? subtitle2(BuildContext context) => textTheme(context).titleSmall;
}

final appTheme = AppTheme();
