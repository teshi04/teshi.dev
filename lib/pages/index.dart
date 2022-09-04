import 'package:auto_size_text/auto_size_text.dart';
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
  final Object _model = Object(
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
        AutoSizeText(
          'お客様に価値を届けるオアダイ',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 300, fontFamily: 'RampartOne'),
          maxLines: 3,
        ),
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
              ),
            ),
            Gap(36)
          ],
        ),
      ],
    ));
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: 0.5, duration: Duration(seconds: 10), vsync: this)
      ..addListener(() {
        _model.rotation.y = _controller.value * 360;
        _model.updateTransform();
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
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
          ]),
          SvgPicture.asset(
            'assets/nekouo.svg',
            width: 100,
            height: 100,
          )
        ],
      ),
      Gap(16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((item) => Padding(
                  padding: EdgeInsets.all(12),
                  child: Tooltip(
                    message: item['url'],
                    margin: const EdgeInsets.only(left: 36),
                    verticalOffset: 11,
                    child: InkWell(
                      child: Text(
                        item['title'] ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () async {
                        await launchUrl(Uri.parse(item['url'] ?? ''));
                      },
                    ),
                  ),
                ))
            .toList(),
      ),
      Gap(32),
      Row(children: [
        _buildCard(),
      ])
    ];
  }

  Widget _buildCard() {
    final suzuriUrl = 'https://suzuri.jp/teshi04';
    return Card(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Tooltip(
              message: suzuriUrl,
              child: InkWell(
                child: Ink.image(
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/suzuri.png'),
                  child: InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse(suzuriUrl));
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(
                'ウサ木',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'SawarabiMincho'),
              ),
            )
          ],
        ));
  }

  Widget _buildCube() {
    final ambient = 0.4;
    final diffuse = 0.8;
    final specular = 0.5;
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
