import 'package:flutter/material.dart';

import 'routes_root.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music to be light',
      initialRoute: '/',
      onGenerateRoute: onGenerateRouteRoot,
    );
  }
}
