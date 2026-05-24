import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'app_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.label,
    this.mode = LabelMode.floating,
    this.controller,
    this.hint,
    this.prefixIcon,
    this.helperText,
    this.errorText,
    this.textInputAction,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
  });

  final String label;
  final LabelMode mode;
  final TextEditingController? controller;
  final String? hint;
  final IconData? prefixIcon;
  final String? helperText;
  final String? errorText;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      mode: widget.mode,
      controller: widget.controller,
      focusNode: widget.focusNode,
      hint: widget.hint,
      prefixIcon: widget.prefixIcon,
      helperText: widget.helperText,
      errorText: widget.errorText,
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _hidden,
      suffixIcon: IconButton(
        tooltip: _hidden ? 'Tampilkan sandi' : 'Sembunyikan sandi',
        onPressed: () => setState(() => _hidden = !_hidden),
        icon: Icon(
          _hidden ? Icons.visibility_off_rounded : Icons.visibility_rounded,
          color: AppColors.outline,
          size: 20,
        ),
      ),
    );
  }
}
