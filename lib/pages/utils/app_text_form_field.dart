import 'package:flutter/material.dart';

import '../../core/app_config.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  final String? hint;
  final FormFieldValidator<String>? validator;
  final Key? textFormFieldKey;
  const AppTextFormField({
    Key? key,
    required this.textEditingController,
    required this.label,
    this.hint,
    this.validator,
    this.textFormFieldKey,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
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
        ),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        // maxLines: 2,
        decoration: InputDecoration(
          label: Text(widget.label),
          hintText: widget.hint,
        ),
      ),
    );
  }
}
