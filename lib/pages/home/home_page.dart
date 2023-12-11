import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/providers.dart';
import '../album/list/album_list_page.dart';
import '../utils/app_loader.dart';
import '../utils/app_messages.dart';
import 'controller/providers.dart';
import 'widgets/album_card.dart';
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
      // body: list.when(data: (data) {
      //   if (data.isEmpty) {
      //     return const Center(
      //       child: Text(
      //           textAlign: TextAlign.center,
      //           'Peça ao seu coordenador para incluir seu email em algum album. Assim você poderá ver os albuns de músicas da sua comunidade.'),
      //     );
      //   } else {
      //     return ListView.builder(
      //       itemCount: data.length,
      //       itemBuilder: (context, index) {
      //         final model = data[index];
      //         return AlbumCard(
      //           model: model,
      //         );
      //       },
      //     );
      //   }
      // }, error: (error, stackTrace) {
      //   log('Erro em Lista de albuns');
      //   log('$error');
      //   log('$stackTrace');
      //   return const Center(
      //     child: Text('Erro em Lista de albuns'),
      //   );
      // }, loading: () {
      //   return const Center(
      //     child: CircularProgressIndicator(),
      //   );
      // }),
    );
  }
}
