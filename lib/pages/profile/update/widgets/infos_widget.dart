import 'package:flutter/material.dart';

import '../../../../core/app_config.dart';

class InfosWidget extends StatelessWidget {
  final String title;
  final List<String>? infos;
  const InfosWidget({
    Key? key,
    required this.title,
    this.infos = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            if (infos == null)
              const Text(
                '.?.',
                style: TextStyle(
                  fontSize: AppFontSize.fontSizeMedium,
                  // color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (infos != null)
              ...infos!
                  .map(
                    (v) => Text(
                      v,
                      style: const TextStyle(
                        fontSize: AppFontSize.fontSizeMedium,
                        // color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  .toList(),
          ],
        ),
      ),
    );
  }
}
