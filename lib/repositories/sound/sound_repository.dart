import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';
import '../../models/sound_model.dart';

abstract interface class SoundRepository {
  Future<Either<RepositoryException, List<SoundModelList>>> list(
      String albumId);
  Future<Either<RepositoryException, SoundModel>> read(String id);
  Future<Either<RepositoryException, String>> create(FormData data);
  Future<Either<RepositoryException, Nil>> update(String id, FormData data);
  Future<Either<RepositoryException, Nil>> delete(String id);
}
