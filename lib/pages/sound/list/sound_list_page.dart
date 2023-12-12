import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/providers.dart';
import '../../utils/app_loader.dart';
import '../../utils/app_messages.dart';
import 'controller/providers.dart';
import 'widgets/sound_card.dart';

class SoundListPage extends ConsumerStatefulWidget {
  const SoundListPage({super.key});
  @override
  ConsumerState<SoundListPage> createState() => _SoundListPageState();
}

class _SoundListPageState extends ConsumerState<SoundListPage>
    with AppMessages, AppLoader {
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(soundListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de músicas'),
      ),
      body: list.when(data: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    textAlign: TextAlign.center, 'Não há músicas neste album.'),
                Text(
                    textAlign: TextAlign.center,
                    'Peça a seu coordenador para adicioná-las.'),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final model = data[index];
              return SoundCard(
                model: model,
              );
            },
          );
        }
      }, error: (error, stackTrace) {
        log('Erro em Lista de músicas');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Column(
            children: [
              Text('Erro em Lista de músicas.'),
              Text('Entre em contato com https://t.me/+YM7CPlJxW5Y5MjM5'),
            ],
          ),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
