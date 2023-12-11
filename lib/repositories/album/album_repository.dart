import 'package:dio/dio.dart';
import 'package:musictobeligth/models/album_model.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';

abstract interface class AlbumRepository {
  Future<Either<RepositoryException, List<AlbumModelList>>> list();
  Future<Either<RepositoryException, AlbumModel>> read(String id);
  Future<Either<RepositoryException, String>> create(FormData data);
  Future<Either<RepositoryException, Nil>> update(String id, FormData data);
  Future<Either<RepositoryException, Nil>> delete(String id);
}
