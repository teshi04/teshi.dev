import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:teshi_dev/pages/index.dart';
import 'package:teshi_dev/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (
      ColorScheme? lightDynamic,
      ColorScheme? darkDynamic,
    ) {
      return MaterialApp(
        title: 'teshi.dev',
        theme: AppTheme.theme(darkDynamic),
        home: TopPage(),
      );
    });
  }
}
