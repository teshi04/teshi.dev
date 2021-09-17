import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
        scaffoldBackgroundColor: Colors.teal[200],
        accentColor: Colors.teal[500],
        cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))));
  }
}
