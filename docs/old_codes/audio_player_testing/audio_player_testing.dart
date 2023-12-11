import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes_root.dart';
import 'controller/controllers.dart';
import 'widgets/player_widget.dart';

class AudioPlayerTesting extends ConsumerStatefulWidget {
  final String urlAudio;
  const AudioPlayerTesting({
    super.key,
    required this.urlAudio,
  });

  @override
  ConsumerState<AudioPlayerTesting> createState() =>
      _AudioPlayerTesting2State();
}

class _AudioPlayerTesting2State extends ConsumerState<AudioPlayerTesting> {
  @override
  Widget build(BuildContext context) {
    log('AudioPlayerTesting2.build');
    final audioController = ref.watch(audioControllerProvider(widget.urlAudio));

    return Scaffold(
      appBar: AppBar(
        title: const Text('AudioPlayerTesting 2'),
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
            audioController.when(
              data: (data) {
                return Column(
                  children: [
                    PlayerWidget(player: data.audioPlayer!),
                  ],
                );
              },
              error: (e, s) {
                return const Text('Erro ao carregar dados...');
              },
              loading: () {
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
