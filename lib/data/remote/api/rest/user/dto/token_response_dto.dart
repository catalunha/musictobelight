import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_response_dto.freezed.dart';
part 'token_response_dto.g.dart';

@freezed
abstract class TokenResponseDto with _$TokenResponseDto {
  factory TokenResponseDto({
    required String refresh,
    required String access,
  }) = _TokenResponseDto;
  factory TokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseDtoFromJson(json);
}
