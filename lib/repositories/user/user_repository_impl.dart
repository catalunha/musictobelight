import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import '../../data/remote/api/client/dio_client.dart'
    if (dart.library.io) '../../data/remote/api/client/dio_client_android.dart'
    if (dart.library.js) '../../data/remote/api/client/dio_client_web.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/functional_program/either.dart';
import '../../data/remote/api/rest/user/dto/confirm_code_body_dto.dart';
import '../../data/remote/api/rest/user/dto/send_code_body_dto.dart';
import '../../data/remote/api/rest/user/dto/token_body_dto.dart';
import '../../data/remote/api/rest/user/user_rest.dart';
import '../../models/user_model.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final DioClient dioClient;
  UserRepositoryImpl({
    required this.dioClient,
  });
  @override
  Future<Either<RepositoryException, String>> login(
      String email, String password) async {
    try {
      final userRest = UserRest(dioClient.unauth);
      final loginResponseDto =
          await userRest.token(TokenBodyDto(email: email, password: password));
      return Success(loginResponseDto.access);
    } on DioException catch (e, s) {
      log('+++ DioException');
      log('Erro em DioException',
          name: 'UserRepositoryImpl.login', error: e, stackTrace: s);
      log(e.toString());
      log(e.message ?? 'Sem e.message');
      log('+++ DioException');
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.unauthorized) {
          return Failure(
              RepositoryException(message: 'Email ou Senha inválidos.'));
        }
      }
      return Failure(RepositoryException(
          message: e.message ?? 'Erro desconhecido ao realizar login 2'));
    }
  }

  @override
  Future<bool> verifyToken(String token) async {
    try {
      final userRest = UserRest(dioClient.unauth);
      final httpResponse = await userRest.tokenVerify({"token": token});
      if (httpResponse.response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e, s) {
      log('Erro ao verificar token',
          name: 'UserRepositoryImpl.verifyToken', error: e, stackTrace: s);
      return false;
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final userRest = UserRest(dioClient.auth);
      final userModel = await userRest.me();
      return Success(userModel);
    } on DioException catch (e, s) {
      log('Erro em UserRepositoryImpl.me DioException',
          name: 'UserRepositoryImpl.me DioException', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro em UserRepositoryImpl.me DioException'));
    } on ArgumentError catch (e, s) {
      log('Erro em UserRepositoryImpl.me ArgumentError',
          name: 'UserRepositoryImpl.me ArgumentError', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> resetpasswordConfirmCode(
      {required String email,
      required String password,
      required String number}) async {
    try {
      final userRest = UserRest(dioClient.unauth);
      await userRest.newPassword(
          ConfirmCodeBodyDto(email: email, password: password, number: number));
      return Success(Nil());
    } on DioException catch (e, s) {
      log(
        "Erro em UserRepositoryImpl.newpassword",
        name: "UserRepositoryImpl.newpassword",
        error: e,
        stackTrace: s,
      );
      String msg = e.message ??
          'Erro desconhecido ao realizar: UserRepositoryImpl.newpassword';
      if (e.response != null &&
          e.response!.statusCode != null &&
          e.response!.statusCode == 400) {
        if (e.response != null && e.response!.data != null) {
          try {
            final erros = e.response?.data;
            if (erros.containsKey('number')) {
              msg = 'Campo número com erro 400: ';
              msg += erros['number']!.join(', ');
            } else if (erros.containsKey('password')) {
              msg = 'Campo senha com erro 400: ';
              msg += erros['password']!.join(', ');
            }
          } catch (e) {
            return Failure(RepositoryException(message: msg));
          }
        }
      } else if (e.response != null &&
          e.response!.statusCode != null &&
          e.response!.statusCode == 404) {
        msg =
            'Não foram encontrados valores correspondentes ao email e numero informado';
      }

      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> resetpasswordSendCode(
      String email) async {
    try {
      final userRest = UserRest(dioClient.unauth);
      await userRest.resetPassword(SendCodeBodyDto(email: email));
      return Success(Nil());
    } on DioException catch (e, s) {
      log(
        "Erro em UserRepositoryImpl.resetpassword",
        name: "UserRepositoryImpl.resetpassword",
        error: e,
        stackTrace: s,
      );
      String msg = e.message ??
          'Erro desconhecido ao realizar: UserRepositoryImpl.resetpassword';
      if (e.response != null &&
          e.response!.statusCode != null &&
          e.response!.statusCode == 404) {
        msg = 'Não foi encontrado um cadastro correspondente a este email';
      }
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> createConfirmCode(
      {required String email,
      required String password,
      required String number}) async {
    try {
      final userRest = UserRest(dioClient.unauth);
      await userRest.createConfirmCode(
          ConfirmCodeBodyDto(email: email, password: password, number: number));
      return Success(Nil());
    } on DioException catch (e, s) {
      log(
        "Erro em UserRepositoryImpl.newpassword",
        name: "UserRepositoryImpl.newpassword",
        error: e,
        stackTrace: s,
      );
      String msg = e.message ??
          'Erro desconhecido ao realizar: UserRepositoryImpl.newpassword';
      if (e.response != null &&
          e.response!.statusCode != null &&
          e.response!.statusCode == 400) {
        if (e.response != null && e.response!.data != null) {
          try {
            final erros = e.response?.data;
            if (erros.containsKey('number')) {
              msg = 'Campo número com erro 400: ';
              msg += erros['number']!.join(', ');
            } else if (erros.containsKey('password')) {
              msg = 'Campo senha com erro 400: ';
              msg += erros['password']!.join(', ');
            }
          } catch (e) {
            return Failure(RepositoryException(message: msg));
          }
        }
      } else if (e.response != null &&
          e.response!.statusCode != null &&
          e.response!.statusCode == 404) {
        msg = 'Não foi possivel confirma o numero.';
      }

      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> createSendCode(String email) async {
    try {
      final userRest = UserRest(dioClient.unauth);
      await userRest.createSendCode(SendCodeBodyDto(email: email));
      return Success(Nil());
    } on DioException catch (e, s) {
      log(
        "Erro em UserRepositoryImpl.createSendCode",
        name: "UserRepositoryImpl.createSendCode",
        error: e,
        stackTrace: s,
      );
      String msg = e.message ??
          'Erro desconhecido ao realizar: UserRepositoryImpl.createSendCode';
      if (e.response != null &&
          e.response!.statusCode != null &&
          e.response!.statusCode == 400) {
        msg = e.response!.data['detail'];
      }
      return Failure(RepositoryException(message: msg));
    }
  }
}
