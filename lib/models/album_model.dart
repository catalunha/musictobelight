import 'package:freezed_annotation/freezed_annotation.dart';

part 'album_model.freezed.dart';
part 'album_model.g.dart';

@freezed
class AudioModel with _$AudioModel {
  @JsonSerializable(includeIfNull: false)
  factory AudioModel({
    String? album,
  }) = _AudioModel;
  factory AudioModel.fromJson(Map<String, dynamic> json) =>
      _$AudioModelFromJson(json);
}
