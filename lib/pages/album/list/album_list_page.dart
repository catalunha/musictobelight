import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/providers.dart';
import '../../utils/app_loader.dart';
import '../../utils/app_messages.dart';
import 'controller/providers.dart';
import 'widgets/album_card.dart';

class AlbumList extends ConsumerStatefulWidget {
  const AlbumList({super.key});
  @override
  ConsumerState<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends ConsumerState<AlbumList>
    with AppMessages, AppLoader {
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(albumListProvider);

    return list.when(data: (data) {
      if (data.isEmpty) {
        return const Center(
          child: Text(
              textAlign: TextAlign.center,
              'Peça ao seu coordenador para incluir seu email em algum album. Assim você poderá ver os albuns de músicas da sua comunidade.'),
        );
      } else {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final model = data[index];
            return AlbumCard(
              model: model,
            );
          },
        );
      }
    }, error: (error, stackTrace) {
      log('Erro em Lista de albuns');
      log('$error');
      log('$stackTrace');
      return const Center(
        child: Text('Erro em Lista de albuns'),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
