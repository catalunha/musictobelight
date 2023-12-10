import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/app_loader.dart';
import '../../utils/app_messages.dart';
import '../controller/providers.dart';

class SubmitWidget extends ConsumerStatefulWidget {
  const SubmitWidget({
    super.key,
    required this.formKey,
    required this.number,
    required this.password,
    required this.email,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController number;
  final TextEditingController password;
  final String email;

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
            showMessageInfo(
                context, 'Campos obrigatórios não foram preenchidos');

          case true:
            ref.read(newPasswordControllerProvider.notifier).newpassword(
                  email: widget.email,
                  number: widget.number.text,
                  password: widget.password.text,
                );
        }
      },
      child: const Text('Alterar senha'),
    );
  }
}
