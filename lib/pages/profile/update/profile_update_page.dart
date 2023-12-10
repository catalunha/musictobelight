import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/remote/api/base_urls.dart';
import '../../../repositories/providers.dart';
import '../../utils/app_import_image.dart';
import '../../utils/app_loader.dart';
import '../../utils/app_messages.dart';
import '../../utils/app_text_form_field.dart';
import 'controller/providers.dart';
import 'controller/states.dart';
import '../../utils/info_widget.dart';
import 'widgets/submit_widget.dart';

/// Update por parte do proprio profile
class ProfileUpdatePage extends ConsumerStatefulWidget {
  const ProfileUpdatePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ProfileUpdatePage> createState() => ProfileUpdatePageState();
}

class ProfileUpdatePageState extends ConsumerState<ProfileUpdatePage>
    with AppLoader, AppMessages {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final description = TextEditingController();
  @override
  void initState() {
    super.initState();
    final profile = ref.read(meProfileProvider);
    name.text = profile?.name ?? '';
    description.text = profile?.description ?? '';

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(regionSelectedProvider.notifier).set(profile?.region);
    // });
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    hideLoader(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(profileUpdateControllerProvider, (previous, next) async {
      switch (next.status) {
        case ProfileUpdateStatus.initial:
        case ProfileUpdateStatus.loading:
          showLoader(context);
        case ProfileUpdateStatus.updated:
          hideLoader(context);
        case ProfileUpdateStatus.success:
          hideLoader(context);
          Navigator.of(context).pop();
        case ProfileUpdateStatus.error:
          hideLoader(context);
          showMessageError(context, next.error);
      }
    });

    final profile = ref.read(meProfileProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar seu perfil'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // InfoWidget(
                    //   title: 'Id',
                    //   info: profile!.id.substring(0, 8),
                    // ),
                    const Text('Confira e mantenha seus dados atualizados'),
                    Wrap(
                      children: [
                        InfoWidget(
                          title: 'É coordenador ?',
                          info: profile.isCoordinator ? "Sim" : "Não",
                        ),
                      ],
                    ),
                    AppTextFormField(
                      label: 'Seu nome',
                      hint: 'Completo',
                      textEditingController: name,
                    ),
                    AppTextFormField(
                      label: 'Sua descrição',
                      hint: 'Completa',
                      textEditingController: description,
                    ),
                    AppImportImage(
                      label:
                          'Click aqui para buscar sua foto, apenas face. Padrão 3x4.',
                      imageUrl: profile.photo?.image == null
                          ? null
                          : const bool.fromEnvironment('development_mode')
                              ? '${ApiV1EndPoints.baseurl}${profile.photo!.image}'
                              : profile.photo!.image,
                      setXFile: (value) {
                        ref.watch(xFileAvatarProvider.notifier).set(value);
                      },
                      maxHeightImage: 150,
                      maxWidthImage: 100,
                    ),
                    SubmitWidget(
                      formKey: formKey,
                      name: name,
                      description: description,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
