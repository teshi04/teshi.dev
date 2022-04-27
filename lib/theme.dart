import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
        scaffoldBackgroundColor: Colors.teal[200],
        cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.teal[500]));
  }
}
