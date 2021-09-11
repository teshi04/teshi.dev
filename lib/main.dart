import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'teshi.dev',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.cyan[200],
          cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)))),
      home: TopPage(),
    );
  }
}

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> with SingleTickerProviderStateMixin {
  final double _ambient = 0.1;
  final double _diffuse = 0.8;
  final double _specular = 0.5;

  late AnimationController _controller;
  late Scene _scene;
  late Object _usagi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        buildCube(),
        SingleChildScrollView(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(height: 600),
            Card(
                color: Colors.white.withOpacity(0.8),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'teshi04',
                        style: TextStyle(fontSize: 32),
                      ),
                      Text(
                        'Yui Matsuura',
                        style: TextStyle(fontSize: 20),
                      ),
                      Gap(16),
                      Text(
                        'teshi04@gmail.com',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                )),
          ],
        )))
      ],
    ));
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this)
          ..addListener(() {
            _usagi.rotation.y = _controller.value * 360;
            _usagi.updateTransform();
            _scene.update();
          })
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildCube() {
    return Cube(
      interactive: false,
      onSceneCreated: (Scene scene) {
        _scene = scene;
        scene.camera.position.z = 10;
        scene.light.position.setFrom(Vector3(0, 10, 10));
        scene.light.setColor(Colors.white, _ambient, _diffuse, _specular);
        _usagi = Object(
            position: Vector3(0, -1.0, 0),
            scale: Vector3(10.0, 10.0, 10.0),
            lighting: true,
            fileName: 'usagi_v1.obj');
        scene.world.add(_usagi);
      },
    );
  }
}
