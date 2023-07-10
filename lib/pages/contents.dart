import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teshi_dev/app_color.dart';
import 'package:teshi_dev/pages/data/url.dart';
import 'package:url_launcher/url_launcher.dart';

class Contents extends StatelessWidget {
  const Contents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('teshi04', style: textTheme.displayMedium),
                  Text(
                    'Yui Matsuura',
                    style: textTheme.headlineSmall
                        ?.copyWith(color: Colors.grey[600]),
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
          ),
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Tooltip(
                      message: item['url'],
                      verticalOffset: 11,
                      child: FilledButton.tonal(
                        style: FilledButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () async {
                          await launchUrl(Uri.parse(item['url'] ?? ''));
                        },
                        child: Row(
                          children: [
                            Text(
                              item['emoji'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'NotoColorEmoji',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item['title'] ?? '',
                              style: textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _buildCard(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const suzuriUrl = 'https://suzuri.jp/teshi04';
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
                image: const AssetImage('assets/suzuri.png'),
                child: InkWell(
                  onTap: () async {
                    await launchUrl(Uri.parse(suzuriUrl));
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: Text(
              'ウサ木',
              style: textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
