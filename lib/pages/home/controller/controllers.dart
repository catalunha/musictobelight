import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'states.dart';

part 'controllers.g.dart';

@riverpod
class AudioController extends _$AudioController {
  @override
  Future<AudioState> build() async {
    final player = AudioPlayer();
    await player.setSourceUrl('http://192.168.10.113:8080/storage/audio02.mp3');
    AsyncData(AudioState());
  }

  Future<void> setUrl() async {
    state = state.copyWith(status: AudioStateStatus.loading);
    final player = AudioPlayer();
    await player.setSourceUrl('http://192.168.10.113:8080/storage/audio02.mp3');
    Duration? dur = await player.getDuration();
    state = state.copyWith(
      status: AudioStateStatus.loaded,
      audioPlayer: player,
      duration: dur ?? const Duration(),
    );
  }
}
