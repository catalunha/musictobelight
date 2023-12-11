import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes_root.dart';
import 'controller/controllers.dart';
import 'widgets/player_widget.dart';

class SoundViewPage extends ConsumerStatefulWidget {
  final String urlAudio;
  const SoundViewPage({
    super.key,
    required this.urlAudio,
  });

  @override
  ConsumerState<SoundViewPage> createState() => _SoundViewPage2State();
}

class _SoundViewPage2State extends ConsumerState<SoundViewPage> {
  @override
  Widget build(BuildContext context) {
    log('SoundViewPage2.build');
    final audioController = ref.watch(audioControllerProvider(widget.urlAudio));

    return Scaffold(
      appBar: AppBar(
        title: const Text('SoundViewPage 2'),
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
