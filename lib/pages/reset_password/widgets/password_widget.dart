import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../utils/app_password_form_field.dart';

class PasswordWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  const PasswordWidget({
    super.key,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return AppPasswordFormField(
      textEditingController: textEditingController,
      label: 'Nova senha',
      hint: 'Mínimo de 8 digitos',
      validator: Validatorless.multiple(
        [
          Validatorless.required('Informação obrigatória'),
          Validatorless.min(6, 'Mínimo de 8 caracteres'),
        ],
      ),
    );
  }
}
