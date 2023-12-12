import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musictobeligth/routes_root.dart';

import '../../../../models/sound_model.dart';
import '../../../../repositories/providers.dart';
import '../../../album/list/controller/providers.dart';
import '../../../utils/app_view_image.dart';
import '../controller/providers.dart';

class SoundCard extends ConsumerWidget {
  final SoundModelList model;
  const SoundCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final album = ref.watch(albumSelectedProvider);
    final profile = ref.watch(meProfileProvider)!;
    String? imageUrl;
    if (const bool.fromEnvironment('development_mode') &&
        model.image?.image != null) {
      imageUrl =
          '${const String.fromEnvironment('url_api_dev')}${model.image!.image}';
    } else {
      imageUrl = model.image?.image;
    }
    return Card(
      child: ListTile(
        leading: AppViewImage(
          imageUrl: imageUrl,
          maxHeightImage: 60,
          maxWidthImage: 60,
        ),
        title: Text(model.name),
        subtitle: Text(model.author.name ?? model.author.user.email),
        trailing: profile.id == album!.coordinator.id
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNameRoot.soundUpsert,
                      arguments: model.id);
                },
                icon: const Icon(Icons.edit))
            : null,
        onTap: () {
          ref.watch(soundIdSelectedProvider.notifier).set(model.id);
          Navigator.of(context).pushNamed(RouteNameRoot.soundView);
        },
      ),
    );
  }
}
