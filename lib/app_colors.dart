import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? primaryColor;
  final Color? secondaryColor;

  const AppColors({
    this.primaryColor,
    this.secondaryColor,
  });

  factory AppColors.light(ColorScheme? dynamic) {
    const appColors = AppColors(
      primaryColor: const Color(0xFFABD3D8),
      secondaryColor: const Color(0xFF7BA2A7),
    );
    return dynamic == null ? appColors : appColors._harmonized(dynamic);
  }

  @override
  AppColors copyWith({Color? primaryColor, Color? secondaryColor}) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  AppColors _harmonized(ColorScheme dynamic) {
    return copyWith(
      primaryColor: primaryColor?.harmonizeWith(dynamic.primary),
      secondaryColor: secondaryColor?.harmonizeWith(dynamic.secondary),
    );
  }
}
