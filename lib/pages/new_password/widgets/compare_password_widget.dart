import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../utils/app_password_form_field.dart';

class ComparePasswordWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextEditingController textEditingControllerCompare;

  const ComparePasswordWidget({
    super.key,
    required this.textEditingController,
    required this.textEditingControllerCompare,
  });

  @override
  Widget build(BuildContext context) {
    return AppPasswordFormField(
      textEditingController: textEditingController,
      label: 'Repita a nova senha',
      hint: 'Mínimo de 8 digitos',
      validator: Validatorless.multiple(
        [
          Validatorless.required('Informação obrigatória'),
          Validatorless.min(8, 'Mínimo de 8 caracteres'),
          Validatorless.compare(
              textEditingControllerCompare, 'Senhas não conferem'),
        ],
      ),
    );
  }
}
