import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../models/profile_model.dart';
import '../../client/dio_client.dart'
    if (dart.library.io) '../../client/dio_client_android.dart'
    if (dart.library.js) '../../client/dio_client_web.dart';

part 'profile_rest.g.dart';

@RestApi()
abstract class ProfileRest {
  factory ProfileRest(DioClient dio) = _ProfileRest;
  @GET('/api/accounts/profile/me/')
  Future<ProfileModel> me();

  //Nao existe create profile. Ele é criado na criação do user

  // @GET('/api/accounts/profile/')
  // Future<List<ProfileModel>> list();

  @GET('/api/accounts/profile/{id}/')
  Future<ProfileListModel> read(@Path() String id);

  @GET('/api/accounts/profile/getbyemail/{email}/')
  Future<ProfileListModel> getByEmail(@Path() String email);

  @PATCH('/api/accounts/profile/{id}/')
  Future<ProfileModel> update(@Path() String id, @Body() FormData data);

  //So o admin deleta user e profile
}
