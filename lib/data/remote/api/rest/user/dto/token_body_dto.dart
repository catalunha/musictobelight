import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_body_dto.freezed.dart';
part 'token_body_dto.g.dart';

@freezed
abstract class TokenBodyDto with _$TokenBodyDto {
  factory TokenBodyDto({
    required String email,
    required String password,
  }) = _TokenBodyDto;
  factory TokenBodyDto.fromJson(Map<String, dynamic> json) =>
      _$TokenBodyDtoFromJson(json);
}
