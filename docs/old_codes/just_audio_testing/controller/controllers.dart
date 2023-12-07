import 'dart:developer';

import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'states.dart';

part 'controllers.g.dart';

@riverpod
class AudioController extends _$AudioController {
  @override
  Future<AudioState> build(String url) async {
    log('AudioController build');
    final player = AudioPlayer();
    log('AudioController build 2');
    // player.setReleaseMode(ReleaseMode.stop);
    // await player.setUrl(url);
    await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    log('AudioController build 3');
    ref.onDispose(() {
      player.dispose();
    });
    log('AudioController build 4');
    return AudioState(
      status: AudioStateStatus.loaded,
      audioPlayer: player,
    );
  }
}
