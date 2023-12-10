import '../../core/exceptions/service_exception.dart';
import '../../core/functional_program/either.dart';

abstract interface class UserService {
  Future<Either<ServiceException, Nil>> login(String email, String password);
  Future<bool> verifyToken();
  Future<void> logout();
  Future<Either<ServiceException, Nil>> register(String email, String password);
  Future<Either<ServiceException, Nil>> newpassword({
    required String email,
    required String password,
    required String number,
  });
}
