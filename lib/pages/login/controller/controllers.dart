import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/app_state_status.dart';
import 'states.dart';

part 'controllers.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  LoginState build() {
    return LoginState();
  }

  Future<void> access() async {
    state = state.copyWith(status: AppStateStatus.loading);
    // await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(status: AppStateStatus.loaded);
  }
}