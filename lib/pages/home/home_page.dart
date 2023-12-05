import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musictobeligth/pages/home/controller/controllers.dart';

import '../../root_routes.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    log('HomePage.build');
    final audioController = ref.watch(audioControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MUSIC TO BE LIGHT'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RootRoutes.login,
                  (route) => false,
                );
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await ref.read(audioControllerProvider.notifier).setUrl();
              },
              child: const Text('GetUrl'),
            ),
            Text('${audioController.duration}')
          ],
        ),
      ),
    );
  }
}
