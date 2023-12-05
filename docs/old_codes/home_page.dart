import 'dart:developer';

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
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () async {
              //     // await player.setSourceUrl(
              //     //     'http://192.168.10.113:8080/storage/audio02.mp3');
              //     // Duration? dur = await player.getDuration();
              //     // setState(() {
              //     //   duration = dur.inSeconds.toString() ?? '';
              //     // });

              //     // await player.resume();
              //   },
              //   child: Text('Play audio02.mp3 $duration'),
              // ),

              // ElevatedButton(
              //   onPressed: () async {
              //     final player = AudioPlayer();
              //     await player.setSource(
              //       AssetSource('sounds/audio01a.wav'),
              //     );
              //     await player.resume();
              //   },
              //   child: const Text('Testando Audio01a.wav'),
              // )
            ],
          ),
        ));
  }
}
