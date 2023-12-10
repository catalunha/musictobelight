import 'package:flutter/material.dart';

import '../../../utils/app_text_form_field.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    required this.address,
  });

  final TextEditingController address;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      label: 'Seu endereço',
      hint: 'Completo',
      textEditingController: address,
    );
  }
}
