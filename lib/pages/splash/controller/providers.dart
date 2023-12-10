import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/functional_program/either.dart';
import '../../../repositories/providers.dart';
import '../../../services/providers.dart';
import 'states.dart';

part 'providers.g.dart';

@riverpod
class SplashController extends _$SplashController {
  @override
  Future<SplashState> build() async {
    //+++ modo lento
    int delaySeconds = 2;
    log('start', name: 'SplashController.build');
    final msgs = <String>[];
    msgs.add('Buscando token de último login ...');
    state =
        AsyncData(SplashState(status: SplashStateStatus.initial, msg: msgs));
    await Future.delayed(Duration(seconds: delaySeconds));
    final hasToken = await ref.read(userServiceProvider).verifyToken();
    if (hasToken) {
      msgs.add('Encontrado ✅.');
      msgs.add('Buscando usuario e perfil...');
      state =
          AsyncData(SplashState(status: SplashStateStatus.initial, msg: msgs));
      final resultGetUser = await ref.read(meUserProvider.notifier).getUser();
      switch (resultGetUser) {
        case Failure(:final exception):
          msgs.add('Falha em encontrar usuário.');
          msgs.add(exception.message);
          state = AsyncData(
              SplashState(status: SplashStateStatus.login, msg: msgs));
        case Success():
          msgs.add('Usuario encontrado com sucesso.');
          state = AsyncData(
              SplashState(status: SplashStateStatus.initial, msg: msgs));
          await Future.delayed(Duration(seconds: delaySeconds));
          final resultGetProfile =
              await ref.read(meProfileProvider.notifier).getProfile();
          switch (resultGetProfile) {
            case Failure(:final exception):
              msgs.add('Falha em encontrar perfil do usuario.');
              msgs.add(exception.message);
              state = AsyncData(
                  SplashState(status: SplashStateStatus.login, msg: msgs));
              await Future.delayed(Duration(seconds: delaySeconds));

            case Success():
              msgs.add('Perfil encontrado com sucesso.');
              state = AsyncData(
                  SplashState(status: SplashStateStatus.initial, msg: msgs));
              await Future.delayed(Duration(seconds: delaySeconds));
              return SplashState(status: SplashStateStatus.logged);
          }
      }
    } else {
      msgs.add('Não encontrado  🚫.');
      msgs.add('Indo para Login...');
      state =
          AsyncData(SplashState(status: SplashStateStatus.initial, msg: msgs));
      await Future.delayed(Duration(seconds: delaySeconds));
      state =
          AsyncData(SplashState(status: SplashStateStatus.login, msg: msgs));
    }
    //--- modo lento

    //+++ modo rápido
    // await Future.delayed( Duration(seconds: delaySeconds));
    // final hasToken = await ref.read(userServiceProvider).verifyToken();
    // if (hasToken) {
    //   return SplashState(status: SplashStateStatus.logged);
    // }
    //--- modo rápido

    return SplashState(status: SplashStateStatus.initial);
  }
}
