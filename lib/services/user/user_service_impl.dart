import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/exceptions/service_exception.dart';
import '../../core/functional_program/either.dart';
import '../../core/navigation_global_key.dart';
import '../../repositories/user/user_repository.dart';
import '../../routes_root.dart';
import './user_service.dart';

class UserServiceImpl implements UserService {
  UserRepository userRepository;
  UserServiceImpl({
    required this.userRepository,
  });
  @override
  Future<Either<ServiceException, Nil>> login(
      String email, String password) async {
    final result = await userRepository.login(email, password);
    switch (result) {
      case Failure(exception: RepositoryException(:final message)):
        return Failure(ServiceException(message: message));
      case Success(value: final token):
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token_access', token);
        return Success(Nil());
    }
  }

  // @override
  // Future<Either<ServiceException, Nil>> register(
  //     String email, String password) async {
  //   final result = await userRepository.create(email, password);
  //   switch (result) {
  //     case Failure(:final exception):
  //       return Failure(ServiceException(message: exception.message));
  //     case Success():
  //       return login(email, password);
  //   }
  // }

  @override
  Future<bool> verifyToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token_access');
    if (token == null) {
      return false;
    }
    return await userRepository.verifyToken(token);
  }

  @override
  Future<void> logout() async {
    //Limpar o token
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.of(NavigationGlobalKey.instance.navigationKey.currentContext!)
        .pushNamedAndRemoveUntil(RouteNameRoot.login, (route) => false);
  }

  // @override
  // Future<Either<ServiceException, Nil>> newpassword({
  //   required String email,
  //   required String password,
  //   required String number,
  // }) async {
  //   final result = await userRepository.resetpasswordConfirmCode(
  //     email: email,
  //     password: password,
  //     number: number,
  //   );
  //   switch (result) {
  //     case Failure(:final exception):
  //       return Failure(ServiceException(message: exception.message));
  //     case Success():
  //       return login(email, password);
  //   }
  // }
}
