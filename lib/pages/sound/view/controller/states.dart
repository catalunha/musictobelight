import 'package:audioplayers/audioplayers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musictobeligth/models/sound_model.dart';

part 'states.freezed.dart';

enum AudioStateStatus {
  initial,
  loading,
  updated,
  loaded,
  message,
  audioStart,
  audioStop,
}

@freezed
class AudioState with _$AudioState {
  factory AudioState({
    @Default(AudioStateStatus.initial) AudioStateStatus status,
    String? message,
    required AudioPlayer audioPlayer,
    required SoundModel sound,
  }) = _AudioState;
}
