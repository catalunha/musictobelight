import 'package:flutter/material.dart';

class GetByEmailDialog extends StatefulWidget {
  const GetByEmailDialog({super.key});

  @override
  State<GetByEmailDialog> createState() => _GetByEmailDialogState();
}

class _GetByEmailDialogState extends State<GetByEmailDialog> {
  final email = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 150,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Buscar usuário por email.'),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(null);
                        },
                        child: const Text('Voltar'),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(email.text);
                        },
                        child: const Text('Save'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
