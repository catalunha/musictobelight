import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';
import '../../data/remote/api/rest/profile/profile_rest.dart';
import '../../models/profile_model.dart';
import '../../models/user_model.dart';
import './profile_repository.dart';
import '../../data/remote/api/client/dio_client.dart'
    if (dart.library.io) '../../data/remote/api/client/dio_client_android.dart'
    if (dart.library.js) '../../data/remote/api/client/dio_client_web.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final DioClient dioClient;
  ProfileRepositoryImpl({
    required this.dioClient,
  });

  @override
  Future<Either<RepositoryException, ProfileModel>> me(
      UserModel userModel) async {
    try {
      // final Response(:data) =
      //     await dioClient.auth.get(ApiV1EndPoints.profileMe);

      // return Success(ProfileModel.fromJson(data));
      final profileRest = ProfileRest(dioClient.auth);
      final profileModel = await profileRest.me();
      return Success(profileModel);
    } on DioException catch (e, s) {
      log('Erro em ProfileRepositoryImpl.me DioException',
          name: 'ProfileRepositoryImpl.me DioException',
          error: e,
          stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro em ProfileRepositoryImpl.me DioException'));
    } on ArgumentError catch (e, s) {
      log('Erro em ProfileRepositoryImpl.me ArgumentError',
          name: 'ProfileRepositoryImpl.me ArgumentError',
          error: e,
          stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, List<ProfileModel>>> list() async {
    try {
      // final Response(:List data) =
      //     await dioClient.auth.get(ApiV1EndPoints.profile);
      // final profileList = data.map((e) => ProfileModel.fromJson(e)).toList();
      // return Success(profileList);
      final profileRest = ProfileRest(dioClient.auth);
      final profileModelList = await profileRest.list();
      return Success(profileModelList);
    } on DioException catch (e, s) {
      log('Erro de DioException em ProfileRepositoryImpl.list',
          name: 'ProfileRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em ProfileRepositoryImpl.list'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em ProfileRepositoryImpl.list',
          name: 'ProfileRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, ProfileModel>> read(String id) async {
    try {
      final profileRest = ProfileRest(dioClient.auth);
      final profileModel = await profileRest.read(id);
      return Success(profileModel);
    } on DioException catch (e, s) {
      log('Erro de DioException em ProfileRepositoryImpl.read',
          name: 'ProfileRepositoryImpl.read', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro de DioException em ProfileRepositoryImpl.read'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em ProfileRepositoryImpl.read',
          name: 'ProfileRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> update(
      String id, FormData data) async {
    try {
      final profileRest = ProfileRest(dioClient.auth);
      await profileRest.update(id, data);
      return Success(Nil());
    } on DioException catch (e, s) {
      log('Erro em ProfileRepositoryImpl.update DioException',
          name: 'ProfileRepositoryImpl.update DioException',
          error: e,
          stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro em ProfileRepositoryImpl.update DioException'));
    } on ArgumentError catch (e, s) {
      log('Erro em ProfileRepositoryImpl.update ArgumentError',
          name: 'ProfileRepositoryImpl.update ArgumentError',
          error: e,
          stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }
}
