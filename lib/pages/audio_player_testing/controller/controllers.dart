import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'states.dart';

part 'controllers.g.dart';

@riverpod
class AudioController extends _$AudioController {
  @override
  Future<AudioState> build(String url) async {
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
  }
}
