import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Scene _scene;
  late Object _usagi;
  double _ambient = 0.1;
  double _diffuse = 0.8;
  double _specular = 0.5;

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
