import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_code_body_dto.freezed.dart';
part 'send_code_body_dto.g.dart';

@freezed
abstract class SendCodeBodyDto with _$SendCodeBodyDto {
  factory SendCodeBodyDto({
    required String email,
  }) = _SendCodeBodyDto;
  factory SendCodeBodyDto.fromJson(Map<String, dynamic> json) =>
      _$SendCodeBodyDtoFromJson(json);
}
