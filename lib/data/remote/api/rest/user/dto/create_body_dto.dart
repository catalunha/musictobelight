import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_body_dto.freezed.dart';
part 'create_body_dto.g.dart';

@freezed
abstract class CreateBodyDto with _$CreateBodyDto {
  factory CreateBodyDto({
    required String email,
    required String password,
  }) = _CreateBodyDto;
  factory CreateBodyDto.fromJson(Map<String, dynamic> json) =>
      _$CreateBodyDtoFromJson(json);
}
