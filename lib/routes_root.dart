import 'package:flutter/material.dart';

import 'pages/audio_player_testing/audio_player_testing.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'pages/not_found_404/not_found_404.dart';
import 'pages/profile/update/profile_update_page.dart';
import 'pages/splash/splash_page.dart';

class RoutesRoot {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String profileUpdate = '/profileUpdate';
  static const String audioPlayerTesting = '/audioPlayerTesting';
}

Route<dynamic> onGenerateRouteRoot(RouteSettings settings) {
  WidgetBuilder builder;
  switch (settings.name) {
    case RoutesRoot.splash:
      builder = (_) => const SplashPage();
      break;
    case RoutesRoot.login:
      builder = (_) => const LoginPage();
      break;
    case RoutesRoot.home:
      builder = (_) => const HomePage();
      break;
    case RoutesRoot.profileUpdate:
      builder = (_) => const ProfileUpdatePage();
      break;
    case RoutesRoot.audioPlayerTesting:
      final arg = settings.arguments as String;
      builder = (_) => AudioPlayerTesting(
            urlAudio: arg,
          );
      break;
    default:
      builder = (_) => const NotFound404();
  }
  return MaterialPageRoute(
    builder: builder,
    settings: settings,
  );
}
