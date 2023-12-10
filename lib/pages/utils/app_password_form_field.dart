import 'package:flutter/material.dart';

import '../../core/app_config.dart';

class AppPasswordFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  final String? hint;
  final FormFieldValidator<String>? validator;
  final Key? textFormFieldKey;
  const AppPasswordFormField({
    Key? key,
    required this.textEditingController,
    required this.label,
    this.hint,
    this.validator,
    this.textFormFieldKey,
  }) : super(key: key);

  @override
  State<AppPasswordFormField> createState() => _AppPasswordFormFieldState();
}

class _AppPasswordFormFieldState extends State<AppPasswordFormField> {
  bool eye = true;
  bool eyeIcon = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 80, right: 80),
      child: TextFormField(
        key: widget.textFormFieldKey,
        controller: widget.textEditingController,
        validator: widget.validator,
        cursorColor: AppColors.red,
        style: const TextStyle(
          fontSize: AppFontSize.fontSizeMedium,
          // color: AppColors.black54,
        ),
        obscureText: eye,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        // keyboardType: TextInputType.number,
        decoration: InputDecoration(
          label: Text(widget.label),
          hintText: widget.hint,
          suffixIcon: InkWell(
            onTap: () {
              setState(
                () {
                  eye = !eye;
                },
              );
            },
            child: Icon(
              eye ? Icons.visibility_off : Icons.visibility,
              // color: AppColors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
