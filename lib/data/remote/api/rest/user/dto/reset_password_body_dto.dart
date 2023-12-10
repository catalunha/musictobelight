import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_body_dto.freezed.dart';
part 'reset_password_body_dto.g.dart';

@freezed
abstract class ResetPasswordBodyDto with _$ResetPasswordBodyDto {
  factory ResetPasswordBodyDto({
    required String email,
  }) = _ResetPasswordBodyDto;
  factory ResetPasswordBodyDto.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordBodyDtoFromJson(json);
}
