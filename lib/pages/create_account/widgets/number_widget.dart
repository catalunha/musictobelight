import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../utils/app_text_form_field.dart';

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      textEditingController: textEditingController,
      label: 'Código enviado ao email',
      validator: Validatorless.required('Informação obrigatória'),
    );
  }
}
