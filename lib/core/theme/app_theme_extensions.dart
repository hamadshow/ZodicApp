import 'package:flutter/material.dart';

class AppThemeExtensions {
  AppThemeExtensions._();

  static TextTheme appTextTheme(BuildContext context) => Theme.of(context).textTheme;

  static ColorScheme appColorScheme(BuildContext context) => Theme.of(context).colorScheme;
}
