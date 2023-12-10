import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/providers.dart';

class SubmitWidget extends ConsumerWidget {
  const SubmitWidget({
    super.key,
    required this.formKey,
    required this.name,
    required this.description,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          final formValid = formKey.currentState?.validate() ?? false;
          if (formValid) {
            // ref.read(profileUpdateControllerProvider.notifier).submitForm(
            //       name: name.text.trim(),
            //       description: description.text.trim(),
            //     );
          }
        },
        child: const Text('Conferido e Atualizado'));
  }
}
