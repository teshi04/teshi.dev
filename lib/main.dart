import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'teshi.dev',
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
      body: Center(
        child: Cube(
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
        ),
      ),
    );
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
}
