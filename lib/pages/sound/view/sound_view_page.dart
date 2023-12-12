import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes_root.dart';
import '../../utils/app_view_image.dart';
import 'controller/controllers.dart';
import 'widgets/author_card.dart';
import 'widgets/description_card.dart';
import 'widgets/player_widget.dart';

class SoundViewPage extends ConsumerStatefulWidget {
  const SoundViewPage({
    super.key,
  });

  @override
  ConsumerState<SoundViewPage> createState() => _SoundViewPage2State();
}

class _SoundViewPage2State extends ConsumerState<SoundViewPage> {
  @override
  Widget build(BuildContext context) {
    log('SoundViewPage.build');
    final soundController = ref.watch(soundControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              soundController.when(
                data: (data) {
                  String? imageUrl;
                  if (const bool.fromEnvironment('development_mode') &&
                      data.sound.image?.image != null) {
                    imageUrl =
                        '${const String.fromEnvironment('url_api_dev')}${data.sound.image!.image}';
                  } else {
                    imageUrl = data.sound.image?.image;
                  }
                  return Column(
                    children: [
                      Text(data.sound.name),
                      AppViewImage(
                        //   imageUrl: data.sound.image == null
                        // ? null
                        // : '',
                        imageUrl: imageUrl,
                        maxHeightImage: 150,
                        maxWidthImage: 300,
                      ),
                      PlayerWidget(player: data.audioPlayer),
                      AuthorCard(
                        model: data.sound.author,
                      ),
                      DescriptionCard(
                        description: data.sound.description,
                      )
                    ],
                  );
                },
                error: (e, s) {
                  return const Text('Erro ao carregar dados...');
                },
                loading: () {
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
