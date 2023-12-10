import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../models/user_model.dart';
import '../../client/dio_client.dart'
    if (dart.library.io) '../../client/dio_client_android.dart'
    if (dart.library.js) '../../client/dio_client_web.dart';
import 'dto/reset_password_body_dto.dart';
import 'dto/token_body_dto.dart';
import 'dto/token_response_dto.dart';
import 'dto/new_password_body_dto.dart';
import 'dto/create_body_dto.dart';

part 'user_rest.g.dart';

@RestApi()
abstract class UserRest {
  factory UserRest(DioClient dio) = _UserRest;

  @POST('/api/accounts/create/')
  Future<void> create(@Body() CreateBodyDto userCreateBodyDto);

  @POST('/api/accounts/token/')
  Future<TokenResponseDto> token(@Body() TokenBodyDto tokenBodyDto);

  @POST('/api/accounts/token/verify/')
  Future<HttpResponse> tokenVerify(@Body() Map<String, dynamic> map);

  @POST('/api/accounts/password/new/')
  Future<void> newPassword(@Body() NewPasswordBodyDto newPasswordBodyDto);

  @POST('/api/accounts/password/reset/')
  Future<void> resetPassword(@Body() ResetPasswordBodyDto resetPasswordBodyDto);

  @GET('/api/accounts/me/')
  Future<UserModel> me();
}
