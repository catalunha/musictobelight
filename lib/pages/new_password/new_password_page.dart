import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/app_loader.dart';
import '../utils/app_messages.dart';
import 'controller/providers.dart';
import 'controller/states.dart';
import 'widgets/compare_password_widget.dart';
import 'widgets/number_widget.dart';
import 'widgets/password_widget.dart';
import 'widgets/submit_widget.dart';

class NewPasswordPage extends ConsumerStatefulWidget {
  final String email;
  const NewPasswordPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  ConsumerState<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends ConsumerState<NewPasswordPage>
    with AppMessages, AppLoader {
  final formKey = GlobalKey<FormState>();
  final number = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    number.dispose();
    password.dispose();
    repeatPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      newPasswordControllerProvider,
      (previous, next) {
        switch (next.status) {
          case NewPasswordStateStatus.initial:
            break;
          case NewPasswordStateStatus.loading:
            showLoader(context);

          case NewPasswordStateStatus.success:
            hideLoader(context);
            Navigator.of(context).pop();
          case NewPasswordStateStatus.error:
            hideLoader(context);
            showMessageError(context, next.error!);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text('Verifique o email informado'),
                Text(widget.email),
                const Text('Você recebeu um email com o título:'),
                const Text('Recuperação de senha'),
                const Text('Anote o código contido nele.'),
                const Text('Informe este código e a nova senha a seguir.'),
                const SizedBox(height: 20),
                NumberWidget(textEditingController: number),
                PasswordWidget(textEditingController: password),
                ComparePasswordWidget(
                  textEditingController: repeatPassword,
                  textEditingControllerCompare: password,
                ),
                const SizedBox(height: 20),
                SubmitWidget(
                  formKey: formKey,
                  email: widget.email,
                  number: number,
                  password: password,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
