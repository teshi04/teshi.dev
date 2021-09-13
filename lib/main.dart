import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:site2021/pages/index.dart';
import 'package:site2021/theme.dart';

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
