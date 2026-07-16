import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:design_system/src/inputs/base_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseOtpTextField extends StatelessWidget {
  const BaseOtpTextField({
    super.key,
    required this.controller,
    this.length = 6,
    this.autofocus = true,
    this.enabled = true,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
  });

  final TextEditingController controller;
  final int length;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(length, (index) {
                    final digit = index < value.text.length
                        ? value.text[index]
                        : '';
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: index == 0 ? 0 : context.designSpacing.xxs,
                          right: index == length - 1
                              ? 0
                              : context.designSpacing.xxs,
                        ),
                        child: _OtpDigitSlot(digit: digit),
                      ),
                    );
                  }),
                );
              },
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 0,
                child: BaseInputField(
                  focusNode: focusNode,
                  controller: controller,
                  autofocus: autofocus,
                  enabled: enabled,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  maxLength: length,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(length),
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  onChanged: onChanged,
                  onFieldSubmitted: onSubmitted,
                ),
              ),
            ),
          ],
        ),
        if (errorText case final error?)
          Padding(
            padding: EdgeInsets.only(top: context.designSpacing.xs),
            child: Text(
              error,
              style: context.designTextTheme.bodySmall?.copyWith(
                color: context.designColors.error,
              ),
            ),
          ),
      ],
    );
  }
}

class _OtpDigitSlot extends StatelessWidget {
  const _OtpDigitSlot({required this.digit});

  final String digit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: context.designColors.outline),
        ),
      ),
      child: Text(
        digit,
        style: context.designTextTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}
