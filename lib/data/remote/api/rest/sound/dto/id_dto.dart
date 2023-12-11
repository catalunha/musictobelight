import 'package:freezed_annotation/freezed_annotation.dart';

part 'id_dto.freezed.dart';
part 'id_dto.g.dart';

@freezed
abstract class AlbumIdDto with _$AlbumIdDto {
  factory AlbumIdDto({
    required String albumId,
  }) = _AlbumIdDto;
  factory AlbumIdDto.fromJson(Map<String, dynamic> json) =>
      _$AlbumIdDtoFromJson(json);
}
