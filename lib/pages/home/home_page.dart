import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes_root.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('MUSIC TO BE LIGHT'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesRoot.login,
                  (route) => false,
                );
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.audio_file),
              title: const Text('audio03.wav'),
              subtitle: const Text('Eu contado. AudioPlayerTesting'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  RoutesRoot.audioPlayerTesting,
                  arguments: 'http://192.168.10.113:8080/storage/audio03.wav',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
