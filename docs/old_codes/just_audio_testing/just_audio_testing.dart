import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes_root.dart';
import 'controller/controllers.dart';
import 'widgets/player.dart';

class JustAudioTesting extends ConsumerStatefulWidget {
  final String urlAudio;
  const JustAudioTesting({
    super.key,
    required this.urlAudio,
  });

  @override
  ConsumerState<JustAudioTesting> createState() => _JustAudioTestingState();
}

class _JustAudioTestingState extends ConsumerState<JustAudioTesting> {
  @override
  Widget build(BuildContext context) {
    log('JustAudioTesting.build');
    final audioController = ref.watch(audioControllerProvider(widget.urlAudio));

    return Scaffold(
      appBar: AppBar(
        title: const Text('JustAudioTesting'),
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
                    Player(player: data.audioPlayer!),
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
