import 'package:musictobeligth/repositories/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/functional_program/either.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
class NewPasswordController extends _$NewPasswordController {
  @override
  NewPasswordState build() {
    return NewPasswordState();
  }

  Future<void> createConfirmCode(
      {required String email,
      required String number,
      required String password}) async {
    state = state.copyWith(status: NewPasswordStateStatus.loading);
    final result = await ref.read(userRepositoryProvider).createConfirmCode(
          email: email,
          password: password,
          number: number,
        );
    switch (result) {
      case Failure(:final exception):
        state = state.copyWith(
            status: NewPasswordStateStatus.error, error: exception.message);
      case Success():
        state = state.copyWith(status: NewPasswordStateStatus.success);
    }
  }
}
