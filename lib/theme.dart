import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:teshi_dev/app_colors.dart';

class AppTheme {
  static ThemeData theme(ColorScheme? dynamic) {
    final themeColors = AppColors.light(dynamic);
    return ThemeData(
      scaffoldBackgroundColor: themeColors.primaryColor,
      cardTheme: CardTheme(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      colorScheme: _lightScheme(dynamic),
    ).copyWith(
      extensions: [
        AppColors.light(dynamic),
      ],
    );
  }

  static _lightScheme(ColorScheme? dynamic) {
    print(dynamic);
    return dynamic == null
        ? ColorScheme.fromSeed(
            seedColor: Color(0xFFABD3D8),
          )
        : dynamic.harmonized();
  }
}
