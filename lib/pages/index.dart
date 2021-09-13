import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/url.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> with SingleTickerProviderStateMixin {
  final double _ambient = 0.1;
  final double _diffuse = 0.8;
  final double _specular = 0.5;
  final Object _usagi = Object(
      position: Vector3(0, -1.0, 0),
      scale: Vector3(10.0, 10.0, 10.0),
      lighting: true,
      fileName: 'assets/usagi_v1.obj');

  late AnimationController _controller;
  Scene? _scene;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        buildCube(),
        ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.6),
                padding: EdgeInsets.all(32),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32), bottom: Radius.zero),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Text(
                            'teshi04',
                            style: TextStyle(fontSize: 32),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Yui Matsuura',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ]),
                        SvgPicture.asset(
                          'assets/icon.svg',
                          width: 100,
                          height: 100,
                        )
                      ],
                    ),
                    Gap(24),
                    Text(
                      'お客さまに価値を届けるオアダイ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Gap(32),
                    ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: EdgeInsets.all(4),
                              child: InkWell(
                                  child: Text(
                                    items[index]['title'] ?? '',
                                    style: TextStyle(
                                        fontSize: 18,
                                        decoration: TextDecoration.underline),
                                  ),
                                  onTap: () async {
                                    await launch(
                                      items[index]['url'] ?? '',
                                    );
                                  }));
                        }),
                    Gap(32),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: () async {
                            await launch(
                              'https://suzuri.jp/teshi04',
                            );
                          },
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/suzuri.jpg',
                                width: 160,
                                color: Colors.black.withOpacity(0.2),
                                colorBlendMode: BlendMode.srcOver,
                              ),
                              Container(
                                margin: EdgeInsets.all(16),
                                child: Text(
                                  'ウサ木グッズ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ))
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
            _scene?.update();
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
        scene.world.add(_usagi);
      },
    );
  }
}
