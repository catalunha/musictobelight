import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';
import '../../models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<RepositoryException, String>> login(
      String email, String password);
  Future<Either<RepositoryException, Nil>> createSendCode(String email);
  Future<Either<RepositoryException, Nil>> createConfirmCode({
    required String email,
    required String password,
    required String number,
  });

  Future<Either<RepositoryException, Nil>> resetpasswordSendCode(String email);
  Future<Either<RepositoryException, Nil>> resetpasswordConfirmCode({
    required String email,
    required String password,
    required String number,
  });

  Future<bool> verifyToken(String token);
  Future<Either<RepositoryException, UserModel>> me();
}
