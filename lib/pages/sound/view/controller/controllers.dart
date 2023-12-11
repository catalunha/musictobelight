import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/functional_program/either.dart';
import '../../../../repositories/providers.dart';
import '../../list/controller/providers.dart';
import 'states.dart';

part 'controllers.g.dart';

@riverpod
class SoundController extends _$SoundController {
  @override
  Future<AudioState> build() async {
    final soundId = ref.watch(soundIdSelectedProvider);
    final soundEither = await ref.read(soundRepositoryProvider).read(soundId);

    switch (soundEither) {
      case Failure(:final exception):
        return throw AsyncError(exception.message, StackTrace.current);
      case Success(value: final sound):
        log('sound: $sound');
        String audioUrl = '';
        if (const bool.fromEnvironment('development_mode')) {
          audioUrl =
              '${const String.fromEnvironment('url_api_dev')}${sound.audio.audio}';
        } else {
          audioUrl = sound.audio.audio;
        }
        // log("sound.audio.audio: ${const bool.fromEnvironment('development_mode')
        //                       ? '${const String.fromEnvironment('url_api_dev')}${sound.audio.audio}'
        //                       : '${sound.audio.audio}'}");
        // const bool.fromEnvironment('development_mode')
        //                       ? '${const String.fromEnvironment('url_api_dev')}${sound.audio.audio}'
        //                       : sound.audio.audio,
        final player = AudioPlayer();
        player.setReleaseMode(ReleaseMode.stop);
        await player.setSourceUrl(audioUrl);
        ref.onDispose(() {
          player.release();
        });

        return AudioState(
          status: AudioStateStatus.loaded,
          audioPlayer: player,
          sound: sound,
        );
    }

/*
    final player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    await player.setSourceUrl(url);
    ref.onDispose(() {
      player.release();
    });

    return AudioState(
      status: AudioStateStatus.loaded,
      audioPlayer: player,
    );
    */
  }
}
