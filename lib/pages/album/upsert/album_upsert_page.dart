import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musictobeligth/pages/album/upsert/widgets/profile_card.dart';
import 'package:validatorless/validatorless.dart';

import '../../utils/app_delete.dart';
import '../../utils/app_import_image.dart';
import '../../utils/app_loader.dart';
import '../../utils/app_messages.dart';
import '../../utils/app_text_form_field.dart';
import '../../utils/state_status.dart';
import 'controller/providers.dart';
import 'controller/states.dart';
import 'widgets/get_by_email_dialog.dart';
import 'widgets/profile_selected_list_widget.dart';

class AlbumUpsertPage extends ConsumerStatefulWidget {
  final String? id;
  const AlbumUpsertPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<AlbumUpsertPage> createState() => _AlbumSavePageState();
}

class _AlbumSavePageState extends ConsumerState<AlbumUpsertPage>
    with AppLoader, AppMessages {
  final _formKey = GlobalKey<FormState>();
  final _nameTec = TextEditingController();
  final _descriptionTec = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameTec.text = '';
  }

  @override
  void dispose() {
    _nameTec.dispose();
    _descriptionTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AlbumUpsertState>(albumUpsertControllerProvider,
        (previous, next) async {
      if (next.status == AlbumUpsertStatus.error) {
        hideLoader(context);
        showMessageError(context, next.error);
      }
      if (next.status == AlbumUpsertStatus.success) {
        hideLoader(context);
        Navigator.of(context).pop();
      }
      if (next.status == AlbumUpsertStatus.loading) {
        showLoader(context);
      }
    });
    ref.listen<ProfileSelectState>(profileSelectedProvider,
        (previous, next) async {
      if (next.status == StateStatus.error) {
        hideLoader(context);
        showMessageError(context, next.message);
      }
      if (next.status == StateStatus.update) {
        hideLoader(context);
        showMessageInfo(context, next.message);
      }
      if (next.status == StateStatus.loading) {
        showLoader(context);
      }
    });
    final albumRead = ref.watch(albumReadProvider(id: widget.id));
    // final profileSelected = ref.watch(profileSelectedProvider);
    // ref.watch(profileSelectedProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Album : ${widget.id == null ? "criar" : "editar"}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            ref.read(albumUpsertControllerProvider.notifier).submitForm(
                  name: _nameTec.text,
                  description: _descriptionTec.text,
                );
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      body: albumRead.when(
        data: (data) {
          String? imageUrl;
          if (data != null) {
            final formState = ref.read(albumUpsertControllerProvider);
            _nameTec.text = formState.model?.name ?? '';
            _descriptionTec.text = formState.model?.description ?? '';
            if (formState.model?.image != null &&
                const bool.fromEnvironment('development_mode')) {
              imageUrl =
                  '${const String.fromEnvironment('url_api_dev')}${formState.model!.image!.image}';
            } else {
              imageUrl = formState.model?.image?.image;
            }
          }
          return Center(
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppTextFormField(
                          label: '* Nome do album',
                          textEditingController: _nameTec,
                          validator: Validatorless.required(
                              'Esta informação é obrigatória'),
                        ),
                        AppTextFormField(
                          label: 'Descrição do album',
                          textEditingController: _descriptionTec,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 15),
                        AppImportImage(
                          label: 'Click aqui para buscar uma imagem.',
                          imageUrl: imageUrl,
                          setXFile: (value) {
                            ref.watch(xFileAvatarProvider.notifier).set(value);
                          },
                          maxHeightImage: 150,
                          maxWidthImage: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Buscar usuário por email '),
                            ElevatedButton(
                                onPressed: () async {
                                  final String? email = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return const GetByEmailDialog();
                                    },
                                  );
                                  if (mounted) {
                                    if (email != null && email.isNotEmpty) {
                                      ref
                                          .read(
                                              profileSelectedProvider.notifier)
                                          .getByEmail(email);
                                    }
                                  }
                                },
                                child: const Icon(Icons.search))
                          ],
                        ),
                        const ProfileSelectedListWidget(),
                        AppDelete(
                          isVisible: data != null,
                          action: () {
                            ref
                                .read(albumUpsertControllerProvider.notifier)
                                .delete();
                          },
                        ),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          log('tem error');
          log('Erro em Lista de albuns');
          log('$error');
          log('$stackTrace');
          return Center(
            child: Text('$error'),
          );
        },
        loading: () {
          log('tem loading');

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
