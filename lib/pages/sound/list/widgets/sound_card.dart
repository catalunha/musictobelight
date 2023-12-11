import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musictobeligth/routes_root.dart';

import '../../../../models/sound_model.dart';
import '../controller/providers.dart';

class SoundCard extends ConsumerWidget {
  final SoundModelList model;
  const SoundCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.queue_music_outlined),
        title: Text(model.name),
        subtitle: Text(model.author.name ?? model.author.user.email),
        // trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        onTap: () {
          ref.watch(soundIdSelectedProvider.notifier).set(model.id);
          Navigator.of(context).pushNamed(RoutesRoot.soundView);
        },
      ),
    );
  }
}
