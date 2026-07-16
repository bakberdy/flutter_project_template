import 'package:design_system/src/tokens/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/build_context_design_x.dart';

class BaseInputField extends StatelessWidget {
  const BaseInputField({
    super.key,
    this.label,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.errorText,
    this.decoration = const InputDecoration(),
    this.style,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.maxLength,
    this.autofocus = false,
    this.autocorrect = true,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
  });

  final String? label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final InputDecoration decoration;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool autofocus;
  final bool autocorrect;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final label = this.label;
    final field = TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      decoration: decoration.copyWith(errorText: errorText),
      style: style,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      autofocus: autofocus,
      autocorrect: autocorrect,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
    );

    if (label == null || label.isEmpty) {
      return field;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: context.designTextTheme.labelLarge),
        SizedBox(height: DesignTokens.spacing.xs),
        field,
      ],
    );
  }
}
