import 'package:flutter/material.dart';

import 'core/navigation_global_key.dart';
import 'routes_root.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music to be light',
      navigatorKey: NavigationGlobalKey.instance.navigationKey,
      initialRoute: '/',
      onGenerateRoute: onGenerateRouteRoot,
    );
  }
}
