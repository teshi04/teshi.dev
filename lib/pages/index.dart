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
  final Object _usagi = Object(
      position: Vector3(0, -1.0, 0),
      scale: Vector3(10.0, 10.0, 10.0),
      lighting: true,
      fileName: 'assets/usagi_v1.obj');

  late AnimationController _controller;
  Scene? _scene;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _buildCube(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
                child: FloatingActionButton(
              elevation: 0,
              highlightElevation: 0,
              hoverElevation: 0,
              child: Icon(
                Icons.keyboard_arrow_up_rounded,
                size: 30,
              ),
              onPressed: () {
                _openBottomSheet();
              },
            )),
            Gap(36)
          ],
        ),
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

    Future.delayed(Duration(milliseconds: 100))
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
        builder: (context) {
          return DraggableScrollableSheet(
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) {
              return ListView(
                padding: EdgeInsets.all(32),
                controller: scrollController,
                children: _buildContents(),
              );
            },
          );
        });
  }

  List<Widget> _buildContents() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'teshi04',
              style: TextStyle(fontSize: 32),
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
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                  padding: EdgeInsets.all(6),
                  child: InkWell(
                      child: Text(
                        item['title'] ?? '',
                        style: TextStyle(
                            fontSize: 18, decoration: TextDecoration.underline),
                      ),
                      onTap: () async {
                        await launch(
                          item['url'] ?? '',
                        );
                      })))
              .toList()),
      Gap(32),
      Row(children: [_buildCard()])
    ];
  }

  Widget _buildCard() {
    return Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Ink.image(
                width: 160,
                height: 160,
                fit: BoxFit.cover,
                image: AssetImage('assets/suzuri.png'),
                child: InkWell(
                  onTap: () async {
                    await launch(
                      'https://suzuri.jp/teshi04',
                    );
                  },
                )),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(
                'ウサ木グッズ',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ));
  }

  Widget _buildCube() {
    final double _ambient = 0.1;
    final double _diffuse = 0.8;
    final double _specular = 0.5;
    return Cube(
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
