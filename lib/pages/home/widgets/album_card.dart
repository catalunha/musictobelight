import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musictobeligth/models/album_model.dart';
import 'package:musictobeligth/pages/home/controller/providers.dart';
import 'package:musictobeligth/routes_root.dart';

class AlbumCard extends ConsumerWidget {
  final AlbumModelList model;
  const AlbumCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.queue_music_outlined),
        title: Text(model.name),
        subtitle: Text(model.coordinator.name ?? model.coordinator.user.email),
        // trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        onTap: () {
          ref.watch(albumIdSelectedProvider.notifier).set(model.id);
          Navigator.of(context).pushNamed(RoutesRoot.soundList);
        },
      ),
    );
  }
}
