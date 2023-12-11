import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../docs/old_codes/audio_player_testing/controller/controllers.dart';

import 'package:musictobeligth/routes_root.dart';
import '../audio_player_testing/controller/states.dart';

class AudioPlayerTesting extends ConsumerStatefulWidget {
  const AudioPlayerTesting({
    super.key,
  });

  @override
  ConsumerState<AudioPlayerTesting> createState() => _AudioPlayerTestingState();
}

class _AudioPlayerTestingState extends ConsumerState<AudioPlayerTesting> {
  AudioPlayer player = AudioPlayer();
  Duration duration = const Duration();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('AudioPlayerTesting.build');
    final audioController = ref.watch(audioControllerProvider);
    final dur = ref.watch(durationPlayerProvider);
    final pos = ref.watch(positionPlayerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AudioPlayerTesting 1'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesRoot.login,
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
            ElevatedButton(
              onPressed: () async {
                ref
                    .read(audioControllerProvider.notifier)
                    .setUrl('http://192.168.10.113:8080/storage/audio03.wav');
              },
              child: const Text('Escolha um audio'),
            ),
            Text('${audioController.duration}'),
            // dur.when(
            //   data: (data) {
            //     return Text('dur: $data');
            //   },
            //   error: (e, s) {
            //     return const Text('Erro dur');
            //   },
            //   loading: () {
            //     return const CircularProgressIndicator();
            //   },
            // ),
            pos.when(
              data: (data) {
                Duration? duration0 = audioController.duration;
                Duration? position0 = data;

                return Column(
                  children: [
                    Text('$data'),
                    Slider(
                      onChanged: (value) async {
                        final duration = duration0;
                        if (duration == null) {
                          return;
                        }
                        final position = value * duration.inMilliseconds;
                        // player.seek(Duration(milliseconds: position.round()));
                        await audioController.audioPlayer!
                            .seek(Duration(milliseconds: position.round()));
                      },
                      value: (duration0 != null &&
                              position0.inMilliseconds > 0 &&
                              position0.inMilliseconds <
                                  duration0.inMilliseconds)
                          ? position0.inMilliseconds / duration0.inMilliseconds
                          : 0.0,
                    ),
                    // Text(
                    //   position0 != null
                    //       ? '$_positionText / $_durationText'
                    //       : duration0 != null
                    //           ? _durationText
                    //           : '',
                    //   style: const TextStyle(fontSize: 16.0),
                    // ),
                  ],
                );
              },
              error: (e, s) {
                return const Text('Erro dur');
              },
              loading: () {
                return const SizedBox.shrink();
                // return const CircularProgressIndicator();
              },
            ),
            if (audioController.status == AudioStateStatus.initial)
              const Text('Preparando audio selecionado'),
            if (audioController.status == AudioStateStatus.loading)
              const CircularProgressIndicator(),
            if (audioController.status == AudioStateStatus.loaded)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await audioController.audioPlayer!.resume();
                    },
                    icon: const Icon(Icons.play_arrow),
                  ),
                  IconButton(
                    onPressed: () async {
                      await audioController.audioPlayer!.pause();
                    },
                    icon: const Icon(Icons.pause),
                  ),
                  IconButton(
                    onPressed: () async {
                      await audioController.audioPlayer!.stop();
                    },
                    icon: const Icon(Icons.stop),
                  ),
                ],
              ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await audioController.audioPlayer!.seek(Duration.zero);
            //   },
            //   child: const Text('seek'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await audioController.audioPlayer!.resume();
            //   },
            //   child: const Text('Resume'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await audioController.audioPlayer!.pause();
            //   },
            //   child: const Text('Pause'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await audioController.audioPlayer!.stop();
            //   },
            //   child: const Text('stop'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await audioController.audioPlayer!.release();
            //   },
            //   child: const Text('Release'),
            // ),
            // const Divider(),
            // ElevatedButton(
            //   onPressed: () async {
            //     player = AudioPlayer();
            //     // Set the release mode to keep the source after playback has completed.
            //     player.setReleaseMode(ReleaseMode.stop);
            //     await player.setSourceUrl(
            //         'http://10.90.13.228:8080/storage/audio03.wav');
            //     duration = await player.getDuration() ?? const Duration();
            //     setState(() {});
            //   },
            //   child: const Text('GetUrl'),
            // ),
            // Text('$duration'),
            // ElevatedButton(
            //   onPressed: () async {
            //     await player.release();
            //   },
            //   child: const Text('release'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await player.seek(const Duration());
            //   },
            //   child: const Text('seek'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await player.resume();
            //   },
            //   child: const Text('resume'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await player.pause();
            //   },
            //   child: const Text('pause'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await player.stop();
            //     setState(() {});
            //   },
            //   child: const Text('stop'),
            // ),
          ],
        ),
      ),
    );
  }
}
