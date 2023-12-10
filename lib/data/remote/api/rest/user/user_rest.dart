import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../models/user_model.dart';
import '../../client/dio_client.dart'
    if (dart.library.io) '../../client/dio_client_android.dart'
    if (dart.library.js) '../../client/dio_client_web.dart';
import 'dto/send_code_body_dto.dart';
import 'dto/token_body_dto.dart';
import 'dto/token_response_dto.dart';
import 'dto/confirm_code_body_dto.dart';

part 'user_rest.g.dart';

@RestApi()
abstract class UserRest {
  factory UserRest(DioClient dio) = _UserRest;

  @POST('/api/accounts/create/sendcode/')
  Future<void> createSendCode(@Body() SendCodeBodyDto userCreateBodyDto);

  @POST('/api/accounts/create/confirmcode/')
  Future<void> createConfirmCode(@Body() ConfirmCodeBodyDto userCreateBodyDto);

  @POST('/api/accounts/token/')
  Future<TokenResponseDto> token(@Body() TokenBodyDto tokenBodyDto);

  @POST('/api/accounts/token/verify/')
  Future<HttpResponse> tokenVerify(@Body() Map<String, dynamic> map);

  @POST('/api/accounts/password/sendcode/')
  Future<void> resetPassword(@Body() SendCodeBodyDto resetPasswordBodyDto);

  @POST('/api/accounts/password/confirmcode/')
  Future<void> newPassword(@Body() ConfirmCodeBodyDto newPasswordBodyDto);

  @GET('/api/accounts/me/')
  Future<UserModel> me();
}
