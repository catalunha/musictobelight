import 'package:musictobeligth/models/album_model.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';

abstract interface class AlbumRepository {
  Future<Either<RepositoryException, List<AlbumModelList>>> list();
  // Future<Either<RepositoryException, AlbumModel>> read(String id);
  // Future<Either<RepositoryException, AlbumModel>> create(
  //     AlbumModel regionModel);
  // Future<Either<RepositoryException, AlbumModel>> update(
  //     AlbumModel regionModel);
  // Future<Either<RepositoryException, Nil>> delete(String id);
}
