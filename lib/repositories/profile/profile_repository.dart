import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';
import '../../models/profile_model.dart';
import '../../models/user_model.dart';

abstract interface class ProfileRepository {
  Future<Either<RepositoryException, ProfileModel>> me(UserModel userModel);
  // Future<Either<RepositoryException, List<ProfileModel>>> list();
  Future<Either<RepositoryException, ProfileListModel>> read(String id);
  Future<Either<RepositoryException, ProfileListModel>> getByEmail(
      String email);
  Future<Either<RepositoryException, Nil>> update(String id, FormData data);
}
