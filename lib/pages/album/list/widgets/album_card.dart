import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musictobeligth/models/album_model.dart';
import 'package:musictobeligth/pages/home/controller/providers.dart';
import 'package:musictobeligth/routes_root.dart';

import '../../../../repositories/providers.dart';
import '../../../utils/app_view_image.dart';
import '../controller/providers.dart';

class AlbumCard extends ConsumerWidget {
  final AlbumModelList model;
  const AlbumCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        subtitle: Text(model.coordinator.name ?? model.coordinator.user.email),
        trailing: profile.isCoordinator && model.coordinator.id == profile.id
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNameRoot.albumUpsert,
                      arguments: model.id);
                },
                icon: const Icon(Icons.edit))
            : null,
        onTap: () {
          ref.watch(albumSelectedProvider.notifier).set(model);
          Navigator.of(context).pushNamed(RouteNameRoot.soundList);
        },
      ),
    );
  }
}
