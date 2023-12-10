import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/remote/api/base_urls.dart';
import '../../routes_root.dart';
import '../new_password/new_password_page.dart';
import '../utils/app_loader.dart';
import '../utils/app_messages.dart';
import 'controller/providers.dart';
import 'controller/states.dart';
import 'widgets/email_widget.dart';
import 'widgets/new_password_widget.dart';
import 'widgets/password_widget.dart';
import 'widgets/submit_widget.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with AppMessages, AppLoader {
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void initState() {
    super.initState();
    // TODO remover email login preenchidos para testes
    if (const bool.fromEnvironment('development_mode')) {
      email.text = 'catalunha.mj@gmail.com';
      password.text = 'cata-123QWE!@#';
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      loginControllerProvider,
      (previous, next) {
        switch (next.status) {
          case LoginStateStatus.initial:
            break;
          case LoginStateStatus.loading:
            showLoader(context);
          case LoginStateStatus.updated:
            hideLoader(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return NewPasswordPage(email: email.text);
                },
              ),
            );
          case LoginStateStatus.success:
            hideLoader(context);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(RoutesRoot.home, (route) => false);
          case LoginStateStatus.error:
            hideLoader(context);
            showMessageError(context, next.error!);
        }
      },
    );
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text('BaseUrl: ${ApiV1EndPoints.baseurl}'),
                const Text('Seja bem vindo ao'),
                const Text(String.fromEnvironment('version')),
                const SizedBox(height: 20),
                EmailWidget(
                  textFormFieldKey: emailKey,
                  textEditingController: email,
                ),
                const SizedBox(height: 20),
                PasswordWidget(textEditingController: password),
                const SizedBox(height: 20),
                SubmitWidget(
                  formKey: formKey,
                  email: email,
                  password: password,
                ),
                const SizedBox(height: 20),
                NewPasswordWidget(emailKey: emailKey, email: email),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
