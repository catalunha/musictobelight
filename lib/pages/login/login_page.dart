import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musictobeligth/pages/create_account/create_account_page.dart';

import '../../data/remote/api/base_urls.dart';
import '../../routes_root.dart';
import '../reset_password/reset_password_page.dart';
import '../utils/app_loader.dart';
import '../utils/app_messages.dart';
import 'controller/providers.dart';
import 'controller/states.dart';
import 'widgets/create_account_widget.dart';
import 'widgets/email_widget.dart';
import 'widgets/password_widget.dart';
import 'widgets/reset_password_widget.dart';
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
  final passwordKey = GlobalKey<FormFieldState>();
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
    log(ApiV1EndPoints.baseurl);
    ref.listen(
      loginControllerProvider,
      (previous, next) {
        switch (next.status) {
          case LoginStateStatus.initial:
            break;
          case LoginStateStatus.loading:
            showLoader(context);
          case LoginStateStatus.resetPassword:
            hideLoader(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ResetPasswordPage(email: email.text);
                },
              ),
            );
          case LoginStateStatus.createAccount:
            hideLoader(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return CreateAccountPage(email: email.text);
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
                const Text('Seja bem vindo ao'),
                const Text('Music To Be Light'),
                const SizedBox(height: 10),
                EmailWidget(
                  textFormFieldKey: emailKey,
                  textEditingController: email,
                ),
                const SizedBox(height: 20),
                PasswordWidget(
                  textEditingController: password,
                  textFormFieldKey: passwordKey,
                ),
                const SizedBox(height: 20),
                SubmitWidget(
                  formKey: formKey,
                  email: email,
                  password: password,
                ),
                const SizedBox(height: 20),
                ResetPasswordWidget(emailKey: emailKey, email: email),
                CreateAccountWidget(emailKey: emailKey, email: email),
                const SizedBox(height: 5),
                const Text(String.fromEnvironment('version')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
