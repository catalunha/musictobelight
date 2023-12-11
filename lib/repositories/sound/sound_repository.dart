import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';
import '../../models/sound_model.dart';

abstract interface class SoundRepository {
  Future<Either<RepositoryException, List<SoundModelList>>> list(
      String albumId);
  Future<Either<RepositoryException, SoundModel>> read(String id);
  // Future<Either<RepositoryException, SoundModel>> create(
  //     SoundModel regionModel);
  // Future<Either<RepositoryException, SoundModel>> update(
  //     SoundModel regionModel);
  // Future<Either<RepositoryException, Nil>> delete(String id);
}
