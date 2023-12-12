import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/providers.dart';
import '../../routes_root.dart';
import '../album/list/album_list_page.dart';
import '../utils/app_loader.dart';
import '../utils/app_messages.dart';
import 'widgets/home_popmenu.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AppMessages, AppLoader {
  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(meProfileProvider)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${profile.name ?? profile.user.email}'),
        actions: const [HomePopMenu()],
      ),
      body: const AlbumList(),
      floatingActionButton: profile.isCoordinator
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteNameRoot.albumUpsert, arguments: null);
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
