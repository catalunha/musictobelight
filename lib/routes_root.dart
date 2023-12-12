import 'package:flutter/material.dart';
import 'package:musictobeligth/pages/sound/list/sound_list_page.dart';

import 'pages/album/upsert/album_upsert_page.dart';
import 'pages/sound/upsert/sound_upsert_page.dart';
import 'pages/sound/view/sound_view_page.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'pages/not_found_404/not_found_404.dart';
import 'pages/profile/update/profile_update_page.dart';
import 'pages/splash/splash_page.dart';

class RouteNameRoot {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String profileUpdate = '/profileUpdate';
  static const String albumUpsert = '/albumUpsert';
  static const String soundList = '/soundList';
  static const String soundView = '/soundView';
  static const String soundUpsert = '/soundUpsert';
}

Route<dynamic> onGenerateRouteRoot(RouteSettings settings) {
  WidgetBuilder builder;
  switch (settings.name) {
    case RouteNameRoot.splash:
      builder = (_) => const SplashPage();
      break;
    case RouteNameRoot.login:
      builder = (_) => const LoginPage();
      break;
    case RouteNameRoot.home:
      builder = (_) => const HomePage();
      break;
    case RouteNameRoot.profileUpdate:
      builder = (_) => const ProfileUpdatePage();
      break;
    case RouteNameRoot.albumUpsert:
      String? id = settings.arguments as String?;
      builder = (_) => AlbumUpsertPage(id: id);
      break;
    case RouteNameRoot.soundList:
      builder = (_) => const SoundListPage();
      break;
    case RouteNameRoot.soundUpsert:
      String? id = settings.arguments as String?;
      builder = (_) => SoundUpsertPage(id: id);
      break;
    case RouteNameRoot.soundView:
      builder = (_) => const SoundViewPage();
      break;
    default:
      builder = (_) => const NotFound404();
  }
  return MaterialPageRoute(
    builder: builder,
    settings: settings,
  );
}
