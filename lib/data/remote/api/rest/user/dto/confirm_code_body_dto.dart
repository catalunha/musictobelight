import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_code_body_dto.freezed.dart';
part 'confirm_code_body_dto.g.dart';

@freezed
abstract class ConfirmCodeBodyDto with _$ConfirmCodeBodyDto {
  factory ConfirmCodeBodyDto({
    required String email,
    required String number,
    required String password,
  }) = _ConfirmCodeBodyDto;
  factory ConfirmCodeBodyDto.fromJson(Map<String, dynamic> json) =>
      _$ConfirmCodeBodyDtoFromJson(json);
}
