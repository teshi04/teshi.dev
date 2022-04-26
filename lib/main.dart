import 'package:flutter/material.dart';
import 'package:teshi_dev/pages/index.dart';
import 'package:teshi_dev/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'teshi.dev',
      theme: AppTheme.theme,
      home: TopPage(),
    );
  }
}
