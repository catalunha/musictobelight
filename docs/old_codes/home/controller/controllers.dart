import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'states.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class AudioController extends _$AudioController {
  @override
  Future<AudioState> build() async {
    final player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);

    await player.setSourceUrl('http://10.90.13.228:8080/storage/audio03.wav');
    Duration dur = await player.getDuration() ?? const Duration();
    return AudioState(audioPlayer: player, duration: dur);
  }

  // Future<void> setUrl() async {
  //   state = state.copyWith(status: AudioStateStatus.loading);
  //   final player = AudioPlayer();
  //   await player.setSourceUrl('http://10.90.13.228:8080/storage/audio02.mp3');
  //   Duration? dur = await player.getDuration();
  //   state = state.copyWith(
  //     status: AudioStateStatus.loaded,
  //     audioPlayer: player,
  //     duration: dur ?? const Duration(),
  //   );
  // }
}
