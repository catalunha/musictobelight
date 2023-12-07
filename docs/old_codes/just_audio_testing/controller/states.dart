import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';

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
    AudioPlayer? audioPlayer,
  }) = _AudioState;
}
