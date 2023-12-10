import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/app_loader.dart';
import '../../utils/app_messages.dart';
import '../controller/providers.dart';

class SubmitWidget extends ConsumerStatefulWidget {
  const SubmitWidget({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;

  @override
  ConsumerState<SubmitWidget> createState() => _SubmitWidgetState();
}

class _SubmitWidgetState extends ConsumerState<SubmitWidget>
    with AppMessages, AppLoader {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.formKey.currentState?.reset();
        switch (widget.formKey.currentState?.validate()) {
          case (false || null):
            showMessageError(context,
                'Campo Email e Senha são obrigatórios. E não foram preenchidos.');

          case true:
            ref
                .read(loginControllerProvider.notifier)
                .login(widget.email.text, widget.password.text);
        }
      },
      child: const Text('Acessar'),
    );
  }
}
