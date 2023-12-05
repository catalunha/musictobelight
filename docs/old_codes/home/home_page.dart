import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musictobeligth/pages/home/controller/controllers.dart';

import '../../root_routes.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  AudioPlayer player = AudioPlayer();
  Duration duration = const Duration();

  @override
  Widget build(BuildContext context) {
    log('HomePage.build');
    final audioController = ref.watch(audioControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MUSIC TO BE LIGHT'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RootRoutes.login,
                  (route) => false,
                );
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            audioController.when(data: (data) {
              return Column(
                children: [
                  Text('${data.duration}'),
                  ElevatedButton(
                    onPressed: () async {
                      await data.audioPlayer!.release();
                    },
                    child: const Text('Release'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await data.audioPlayer!.seek(Duration.zero);
                    },
                    child: const Text('seek'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await data.audioPlayer!.resume();
                    },
                    child: const Text('Resume'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await data.audioPlayer!.pause();
                    },
                    child: const Text('Pause'),
                  )
                ],
              );
            }, error: (e, s) {
              return const Center(
                child: Text('Erro'),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
            const Divider(),
            ElevatedButton(
              onPressed: () async {
                player = AudioPlayer();
                // Set the release mode to keep the source after playback has completed.
                player.setReleaseMode(ReleaseMode.stop);
                await player.setSourceUrl(
                    'http://10.90.13.228:8080/storage/audio03.wav');
                duration = await player.getDuration() ?? const Duration();
                setState(() {});
              },
              child: const Text('GetUrl'),
            ),
            Text('$duration'),
            ElevatedButton(
              onPressed: () async {
                await player.release();
              },
              child: const Text('release'),
            ),
            ElevatedButton(
              onPressed: () async {
                await player.seek(const Duration());
              },
              child: const Text('seek'),
            ),
            ElevatedButton(
              onPressed: () async {
                await player.resume();
              },
              child: const Text('resume'),
            ),
            ElevatedButton(
              onPressed: () async {
                await player.pause();
              },
              child: const Text('pause'),
            ),
            ElevatedButton(
              onPressed: () async {
                await player.stop();
                setState(() {});
              },
              child: const Text('stop'),
            ),
          ],
        ),
      ),
    );
  }
}
