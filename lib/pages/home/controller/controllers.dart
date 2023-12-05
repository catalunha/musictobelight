import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'states.dart';

part 'controllers.g.dart';

@riverpod
class AudioController extends _$AudioController {
  @override
  AudioState build() {
    return AudioState();
  }

  Future<void> setUrl(String url) async {
    state = state.copyWith(status: AudioStateStatus.loading);
    final player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    await player.setSourceUrl(url);
    Duration? dur = await player.getDuration();
    // await player.resume();
    // await player.pause();
    state = state.copyWith(
      status: AudioStateStatus.loaded,
      audioPlayer: player,
      duration: dur ?? const Duration(),
    );
  }
}

@riverpod
Stream<Duration?> durationPlayer(DurationPlayerRef ref) {
  final audio = ref.watch(audioControllerProvider);
  log('durationPlayer ${audio.duration}');
  return audio.audioPlayer!.onDurationChanged;
}

@riverpod
Stream<Duration> positionPlayer(PositionPlayerRef ref) {
  final audio = ref.watch(audioControllerProvider);
  log('positionPlayer');
  return audio.audioPlayer!.onPositionChanged;
}
