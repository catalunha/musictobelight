import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musictobeligth/models/profile_model.dart';

import 'image_model.dart';

part 'album_model.freezed.dart';
part 'album_model.g.dart';

@freezed
class AlbumModel with _$AlbumModel {
  @JsonSerializable(includeIfNull: false)
  factory AlbumModel({
    String? name,
    String? description,
    ProfileModel? coordinator,
    ImageModel? image,
    @Default([]) List<ProfileModel> listeners,
  }) = _AlbumModel;
  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);
}

@freezed
class AlbumModelList with _$AlbumModelList {
  @JsonSerializable(includeIfNull: false)
  factory AlbumModelList({
    required String id,
    required String name,
    required ProfileModel coordinator,
    ImageModel? image,
  }) = _AlbumModelList;
  factory AlbumModelList.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelListFromJson(json);
}
