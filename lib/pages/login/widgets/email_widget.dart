import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../utils/app_text_form_field.dart';

class EmailWidget extends StatelessWidget {
  final Key? textFormFieldKey;
  final TextEditingController textEditingController;

  const EmailWidget({
    Key? key,
    this.textFormFieldKey,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      textFormFieldKey: textFormFieldKey,
      textEditingController: textEditingController,
      label: 'Informe seu email',
      validator: Validatorless.multiple(
        [
          Validatorless.required('Informação obrigatória'),
          Validatorless.email('Informe email válido'),
        ],
      ),
    );
  }
}
