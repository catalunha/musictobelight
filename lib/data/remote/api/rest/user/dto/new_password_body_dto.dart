import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_password_body_dto.freezed.dart';
part 'new_password_body_dto.g.dart';

@freezed
abstract class NewPasswordBodyDto with _$NewPasswordBodyDto {
  factory NewPasswordBodyDto({
    required String email,
    required String password,
    required String number,
  }) = _NewPasswordBodyDto;
  factory NewPasswordBodyDto.fromJson(Map<String, dynamic> json) =>
      _$NewPasswordBodyDtoFromJson(json);
}
