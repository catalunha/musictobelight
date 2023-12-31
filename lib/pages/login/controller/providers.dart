import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/functional_program/either.dart';
import '../../../repositories/providers.dart';
import '../../../services/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  LoginState build() {
    return LoginState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: LoginStateStatus.loading);
    final userService = ref.read(userServiceProvider);
    final result = await userService.login(email, password);
    switch (result) {
      case Failure(:final exception):
        state = state.copyWith(
            status: LoginStateStatus.error, error: exception.message);
      case Success():
        final resultGetUser = await ref.read(meUserProvider.notifier).getUser();
        switch (resultGetUser) {
          case Failure(:final exception):
            state = state.copyWith(
                status: LoginStateStatus.error, error: exception.message);
          case Success():
            final resultGetProfile =
                await ref.read(meProfileProvider.notifier).getProfile();
            switch (resultGetProfile) {
              case Failure(:final exception):
                state = state.copyWith(
                    status: LoginStateStatus.error, error: exception.message);
              case Success():
                state = state.copyWith(status: LoginStateStatus.success);
            }
        }
    }
  }

  Future<void> resetpasswordSendCode(String email) async {
    state = state.copyWith(status: LoginStateStatus.loading);
    final result =
        await ref.read(userRepositoryProvider).resetpasswordSendCode(email);
    switch (result) {
      case Failure(:final exception):
        state = state.copyWith(
            status: LoginStateStatus.error, error: exception.message);
      case Success():
        state = state.copyWith(status: LoginStateStatus.resetPassword);
    }
  }

  Future<void> createSendCode(String email) async {
    state = state.copyWith(status: LoginStateStatus.loading);
    final result = await ref.read(userRepositoryProvider).createSendCode(email);
    switch (result) {
      case Failure(:final exception):
        state = state.copyWith(
            status: LoginStateStatus.error, error: exception.message);
      case Success():
        state = state.copyWith(status: LoginStateStatus.createAccount);
    }
  }
}
