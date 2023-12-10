import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/app_loader.dart';
import '../../utils/app_messages.dart';
import '../controller/providers.dart';

class CreateAccountWidget extends ConsumerStatefulWidget {
  const CreateAccountWidget({
    super.key,
    required this.emailKey,
    required this.email,
  });

  final GlobalKey<FormFieldState> emailKey;
  final TextEditingController email;

  @override
  ConsumerState<CreateAccountWidget> createState() =>
      _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends ConsumerState<CreateAccountWidget>
    with AppMessages, AppLoader {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.emailKey.currentState?.reset();
        switch (widget.emailKey.currentState?.validate()) {
          case (false || null):
            showMessageError(
                context, 'Campo email é obrigatório. E não foi preenchido');

          case true:
            ref
                .read(loginControllerProvider.notifier)
                .createSendCode(widget.email.text);
        }
      },
      child: const Text('Criar uma conta.'),
    );
  }
}
