import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teshi_dev/app_color.dart';
import 'package:teshi_dev/pages/data/url.dart';
import 'package:url_launcher/url_launcher.dart';

/// 中身
class Contents extends StatelessWidget {
  const Contents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      child: const Column(
        children: [
          IntroductionWidget(),
          SizedBox(height: 32),
          MenuListWidget(),
          SizedBox(height: 32),
          Row(
            children: [
              CardWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

/// 名前とアイコン
class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('teshi04', style: textTheme.displayMedium),
            Text(
              'Yui Matsuura',
              style: textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          radius: 64,
          child: SvgPicture.asset(
            'assets/nekouo.svg',
          ),
        )
      ],
    );
  }
}

/// リンク一覧
class MenuListWidget extends StatelessWidget {
  const MenuListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 0,
              ),
              child: Tooltip(
                message: item.url,
                verticalOffset: 0,
                child: FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: () async {
                    await launchUrl(Uri.parse(item.url));
                  },
                  child: Row(
                    children: [
                      Text(
                        item.emoji,
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        item.title,
                        style: textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

/// ウサ木カード
class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);
  final _suzuriUrl = 'https://suzuri.jp/teshi04';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Tooltip(
            message: _suzuriUrl,
            child: InkWell(
              child: Ink.image(
                width: 160,
                height: 160,
                fit: BoxFit.cover,
                image: const AssetImage('assets/suzuri.png'),
                child: InkWell(
                  onTap: () async {
                    await launchUrl(Uri.parse(_suzuriUrl));
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'ウサ木',
              style: textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
