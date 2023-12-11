import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_model.freezed.dart';
part 'audio_model.g.dart';

@freezed
class AudioModel with _$AudioModel {
  @JsonSerializable(includeIfNull: false)
  factory AudioModel({
    required String audio,
  }) = _AudioModel;
  factory AudioModel.fromJson(Map<String, dynamic> json) =>
      _$AudioModelFromJson(json);
}
