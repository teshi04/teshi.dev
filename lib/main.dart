import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'teshi.dev',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.teal[500],
          cardTheme: CardTheme(
              elevation: 0,
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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(height: 600),
            Container(
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
                        'icon.svg',
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
                  InkWell(
                      child: Text(
                        'GitHub',
                        style: TextStyle(
                            fontSize: 18, decoration: TextDecoration.underline),
                      ),
                      onTap: () async {
                        await launch(
                          'https://github.com/teshi04',
                        );
                      }),
                  InkWell(
                      child: Text(
                        'Twitter',
                        style: TextStyle(
                            fontSize: 18, decoration: TextDecoration.underline),
                      ),
                      onTap: () async {
                        await launch(
                          'https://github.com/teshi04',
                        );
                      }),
                  InkWell(
                      child: Text(
                        'Note',
                        style: TextStyle(
                            fontSize: 18, decoration: TextDecoration.underline),
                      ),
                      onTap: () async {
                        await launch(
                          'https://github.com/teshi04',
                        );
                      }),
                  InkWell(
                      child: Text(
                        'Blog',
                        style: TextStyle(
                            fontSize: 18, decoration: TextDecoration.underline),
                      ),
                      onTap: () async {
                        await launch(
                          'https://github.com/teshi04',
                        );
                      }),
                  InkWell(
                      child: Text(
                        'Scrapbox',
                        style: TextStyle(
                            fontSize: 18, decoration: TextDecoration.underline),
                      ),
                      onTap: () async {
                        await launch(
                          'https://github.com/teshi04',
                        );
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
                              'suzuri.jpg',
                              width: 250,
                              color: Colors.black.withOpacity(0.2),
                              colorBlendMode: BlendMode.srcOver,
                            ),
                            Container(
                              margin: EdgeInsets.all(16),
                              child: Text(
                                'ウサ木',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
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
