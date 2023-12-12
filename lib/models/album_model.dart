import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musictobeligth/models/profile_model.dart';

import 'image_model.dart';

part 'album_model.freezed.dart';
part 'album_model.g.dart';

@freezed
class AlbumModel with _$AlbumModel {
  @JsonSerializable(includeIfNull: false)
  factory AlbumModel({
    required String id,
    required String name,
    String? description,
    required ProfileModel coordinator,
    ImageModel? image,
    @Default([]) List<ProfileListModel> listeners,
  }) = _AlbumModel;
  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);
}

@freezed
class AlbumUpsertModel with _$AlbumUpsertModel {
  @JsonSerializable(includeIfNull: false)
  factory AlbumUpsertModel({
    String? id,
    required String name,
    String? description,
    required String coordinator,
    @Default([]) List<String> listeners,
  }) = _AlbumUpsertModel;
  factory AlbumUpsertModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumUpsertModelFromJson(json);
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
