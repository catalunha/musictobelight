import 'package:flutter/material.dart';

import '../../core/app_config.dart';

class InfoWidget extends StatelessWidget {
  final String title;
  final String? info;
  final Color color;
  const InfoWidget({
    Key? key,
    required this.title,
    this.info,
    this.color = Colors.black26,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: AppFontSize.fontSizeSmall,
                // color: AppColors.black54,
              ),
            ),
            Text(
              info ?? '.?.',
              style: const TextStyle(
                fontSize: AppFontSize.fontSizeMedium,
                // color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
