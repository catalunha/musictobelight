import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musictobeligth/models/profile_model.dart';

import '../../../utils/app_view_image.dart';
import '../controller/providers.dart';

class ProfileCard extends ConsumerWidget {
  final ProfileListModel model;
  const ProfileCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? imageUrl;
    if (const bool.fromEnvironment('development_mode') &&
        model.photo?.image != null) {
      imageUrl =
          '${const String.fromEnvironment('url_api_dev')}${model.photo!.image}';
    } else {
      imageUrl = model.photo?.image;
    }
    return SizedBox(
      width: 300,
      child: InkWell(
        onLongPress: () {
          ref.read(profileSelectedProvider.notifier).delete(model.id);
        },
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: AppViewImage(
                  imageUrl: imageUrl,
                  maxHeightImage: 60,
                  maxWidthImage: 60,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${model.name}'),
                  Text(model.user.email),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
