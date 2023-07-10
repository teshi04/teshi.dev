import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:teshi_dev/pages/contents.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  TopPageState createState() => TopPageState();
}

class TopPageState extends State<TopPage> with SingleTickerProviderStateMixin {
  final _model = Object(
    position: Vector3(0, -1.0, 0),
    rotation: Vector3(0, -90.0, 0.0),
    scale: Vector3(10.0, 10.0, 10.0),
    lighting: true,
    fileName: 'assets/nekouo.obj',
  );

  late AnimationController _controller;
  Scene? _scene;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AutoSizeText(
            'お客様に価値を届けるオアダイ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 300, fontFamily: 'RampartOne'),
            maxLines: 3,
          ),
          _buildCube(),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 32),
            child: FloatingActionButton(
              elevation: 0,
              highlightElevation: 0,
              hoverElevation: 0,
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                size: 36,
              ),
              onPressed: () {
                _openBottomSheet();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.5,
      duration: const Duration(seconds: 10),
      vsync: this,
    )
      ..addListener(() {
        _model.rotation.y = _controller.value * 360;
        _model.updateTransform();
        _scene?.update();
      })
      ..repeat();

    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => _openBottomSheet());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          snap: true,
          initialChildSize: 0.9,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: const Contents(),
            );
          },
        );
      },
    );
  }

  Widget _buildCube() {
    const ambient = 0.4;
    const diffuse = 0.8;
    const specular = 0.5;
    return Cube(
      onSceneCreated: (Scene scene) {
        _scene = scene;
        scene.camera.position.z = 15;
        scene.light.position.setFrom(Vector3(0, 10, 10));
        scene.light.setColor(Colors.white, ambient, diffuse, specular);
        scene.world.add(_model);
      },
    );
  }
}
