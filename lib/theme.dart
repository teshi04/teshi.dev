import 'package:flutter/material.dart';
import 'package:teshi_dev/app_color.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.primaryColor,
      colorSchemeSeed: AppColors.primaryColor,
      brightness: Brightness.light,
      fontFamily: 'MPLUSRounded1c',
      useMaterial3: true,
    );
  }
}
