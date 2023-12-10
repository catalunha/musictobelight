import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/app_loader.dart';
import '../../utils/app_messages.dart';
import '../controller/providers.dart';

class ResetPasswordWidget extends ConsumerStatefulWidget {
  const ResetPasswordWidget({
    super.key,
    required this.emailKey,
    required this.email,
  });

  final GlobalKey<FormFieldState> emailKey;
  final TextEditingController email;

  @override
  ConsumerState<ResetPasswordWidget> createState() => _NewPasswordWidgetState();
}

class _NewPasswordWidgetState extends ConsumerState<ResetPasswordWidget>
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
                .resetpasswordSendCode(widget.email.text);
        }
      },
      child: const Text('Solicitar nova senha'),
    );
  }
}
