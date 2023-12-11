import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes_root.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splashController = ref.watch(splashControllerProvider);
    ref.listen(splashControllerProvider, (previous, next) {
      next.when(
        data: (data) {
          switch (data.status) {
            case SplashStateStatus.login:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(RouteName.login, (route) => false);
            case SplashStateStatus.logged:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(RouteName.home, (route) => false);
            case _:
              break;
          }
        },
        error: (error, stackTrace) {
          return Navigator.of(context)
              .pushNamedAndRemoveUntil(RouteName.login, (route) => false);
        },
        loading: () {},
      );
    });
    return Scaffold(
        body: splashController.when(
      data: (data) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              for (String msg in data.msg) Text(msg)
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text('Oops. Ocorreu algum erro'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
