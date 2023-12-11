import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musictobeligth/models/profile_model.dart';

import 'album_model.dart';
import 'audio_model.dart';
import 'image_model.dart';

part 'sound_model.freezed.dart';
part 'sound_model.g.dart';

@freezed
class SoundModel with _$SoundModel {
  @JsonSerializable(includeIfNull: false)
  factory SoundModel({
    required String id,
    required String name,
    String? description,
    required ProfileModel author,
    required AlbumModel album,
    ImageModel? image,
    required AudioModel audio,
  }) = _SoundModel;
  factory SoundModel.fromJson(Map<String, dynamic> json) =>
      _$SoundModelFromJson(json);
}

@freezed
class SoundModelList with _$SoundModelList {
  @JsonSerializable(includeIfNull: false)
  factory SoundModelList({
    required String id,
    required String name,
    required ProfileModel author,
    ImageModel? image,
  }) = _SoundModelList;
  factory SoundModelList.fromJson(Map<String, dynamic> json) =>
      _$SoundModelListFromJson(json);
}
