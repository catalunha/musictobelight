import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:musictobeligth/models/album_model.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';
import '../../data/remote/api/client/dio_client.dart'
    if (dart.library.io) '../../data/remote/api/client/dio_client_android.dart'
    if (dart.library.js) '../../data/remote/api/client/dio_client_web.dart';
import '../../data/remote/api/rest/album/album_rest.dart';
import 'album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final DioClient dioClient;
  AlbumRepositoryImpl({
    required this.dioClient,
  });
  @override
  Future<Either<RepositoryException, List<AlbumModelList>>> list() async {
    try {
      final albumRest = AlbumRest(dioClient.auth);
      final albumModelList = await albumRest.list();
      return Success(albumModelList);
    } on DioException catch (e, s) {
      log('Erro de DioException em AlbumRepositoryImpl.list',
          name: 'AlbumRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em AlbumRepositoryImpl.list'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em AlbumRepositoryImpl.list',
          name: 'AlbumRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, AlbumModel>> read(String id) async {
    try {
      final albumRest = AlbumRest(dioClient.auth);
      final albumModel = await albumRest.read(id);
      return Success(albumModel);
    } on DioException catch (e, s) {
      log('Erro de DioException em AlbumRepositoryImpl.read',
          name: 'AlbumRepositoryImpl.read', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em AlbumRepositoryImpl.read'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em AlbumRepositoryImpl.read',
          name: 'AlbumRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, String>> create(FormData data) async {
    try {
      final albumRest = AlbumRest(dioClient.auth);
      final albumModelNew = await albumRest.create(data);
      return Success(albumModelNew);
    } on DioException catch (e, s) {
      log('Erro de DioException em AlbumRepositoryImpl.create',
          name: 'AlbumRepositoryImpl.create', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em AlbumRepositoryImpl.create'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em AlbumRepositoryImpl.create',
          name: 'AlbumRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> update(
      String id, FormData data) async {
    try {
      final albumRest = AlbumRest(dioClient.auth);
      await albumRest.update(id, data);
      return Success(Nil());
    } on DioException catch (e, s) {
      log('Erro de DioException em AlbumRepositoryImpl.update',
          name: 'AlbumRepositoryImpl.update', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em AlbumRepositoryImpl.update'));
    } on ArgumentError catch (e, s) {
      log('Erro de ArgumentError em AlbumRepositoryImpl.update',
          name: 'AlbumRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> delete(String id) async {
    try {
      final albumRest = AlbumRest(dioClient.auth);
      final httpResponse = await albumRest.delete(id);
      if (httpResponse.response.statusCode == 200) {
        return Success(Nil());
      }
      throw Exception('Erro desconhecido em AlbumRepositoryImpl.delete');
    } on DioException catch (e, s) {
      log('Erro de DioException em AlbumRepositoryImpl.update',
          name: 'AlbumRepositoryImpl.update', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: e.response?.data.toString() ??
              'Erro de DioException em AlbumRepositoryImpl.update'));
    } catch (e, s) {
      log('Erro de ArgumentError em AlbumRepositoryImpl.update',
          name: 'AlbumRepositoryImpl.list', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e as String));
    }
  }
}
