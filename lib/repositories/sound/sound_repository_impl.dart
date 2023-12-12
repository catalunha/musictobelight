import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:musictobeligth/data/remote/api/rest/sound/dto/id_dto.dart';
import 'package:musictobeligth/models/sound_model.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';
import '../../data/remote/api/client/dio_client.dart'
    if (dart.library.io) '../../data/remote/api/client/dio_client_android.dart'
    if (dart.library.js) '../../data/remote/api/client/dio_client_web.dart';
import '../../data/remote/api/rest/sound/sound_rest.dart';
import 'sound_repository.dart';

class SoundRepositoryImpl implements SoundRepository {
  final DioClient dioClient;
  SoundRepositoryImpl({
    required this.dioClient,
  });
  @override
  Future<Either<RepositoryException, List<SoundModelList>>> list(
      String albumId) async {
    try {
      final soundRest = SoundRest(dioClient.auth);
      final soundModelList = await soundRest.list(AlbumIdDto(albumId: albumId));
      return Success(soundModelList);
    } on DioException catch (e, s) {
      log('Erro de DioException em SoundRepositoryImpl.list',
          name: 'SoundRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em SoundRepositoryImpl.list'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em SoundRepositoryImpl.list',
          name: 'SoundRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, SoundModel>> read(String id) async {
    try {
      final soundRest = SoundRest(dioClient.auth);
      log('read $id');
      final soundModel = await soundRest.read(id);
      return Success(soundModel);
    } on DioException catch (e, s) {
      log('Erro de DioException em SoundRepositoryImpl.read',
          name: 'SoundRepositoryImpl.read', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em SoundRepositoryImpl.read'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em SoundRepositoryImpl.read',
          name: 'SoundRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, String>> create(FormData data) async {
    try {
      final soundRest = SoundRest(dioClient.auth);
      final soundModelNew = await soundRest.create(data);
      return Success(soundModelNew);
    } on DioException catch (e, s) {
      log('Erro de DioException em SoundRepositoryImpl.create',
          name: 'SoundRepositoryImpl.create', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em SoundRepositoryImpl.create'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em SoundRepositoryImpl.create',
          name: 'SoundRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> update(
      String id, FormData data) async {
    try {
      final soundRest = SoundRest(dioClient.auth);
      await soundRest.update(id, data);
      return Success(Nil());
    } on DioException catch (e, s) {
      log('Erro de DioException em SoundRepositoryImpl.update',
          name: 'SoundRepositoryImpl.update', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em SoundRepositoryImpl.update'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em SoundRepositoryImpl.update',
          name: 'SoundRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> delete(String id) async {
    try {
      final soundRest = SoundRest(dioClient.auth);
      final httpResponse = await soundRest.delete(id);
      if (httpResponse.response.statusCode == 200) {
        return Success(Nil());
      }
      throw Exception('Erro desconhecido em SoundRepositoryImpl.delete');
    } on DioException catch (e, s) {
      log('Erro de DioException em SoundRepositoryImpl.update',
          name: 'SoundRepositoryImpl.update', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em SoundRepositoryImpl.update'));
    } catch (e, s) {
      log('Erro de ArgumentError em SoundRepositoryImpl.update',
          name: 'SoundRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e as String));
    }
  }
}
