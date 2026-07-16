import 'package:design_system/src/tokens/design_tokens.dart';
import 'package:design_system/src/buttons/base_button.dart';
import 'package:design_system/src/inputs/base_otp_text_field.dart';
import 'package:flutter/material.dart';

class BaseOtpVerificationBottomSheet extends StatefulWidget {
  const BaseOtpVerificationBottomSheet({
    super.key,
    required this.description,
    this.buttonLabel,
    this.errorText,
    this.otpLength = 6,
    this.loading = false,
    this.onOtpSubmitted,
  });

  final String description;
  final String? buttonLabel;
  final String? errorText;
  final int otpLength;
  final bool loading;
  final ValueChanged<String>? onOtpSubmitted;

  @override
  State<BaseOtpVerificationBottomSheet> createState() =>
      _BaseOtpVerificationBottomSheetState();
}

class _BaseOtpVerificationBottomSheetState
    extends State<BaseOtpVerificationBottomSheet> {
  final otpCodeController = TextEditingController();
  String? errorText;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    errorText = widget.errorText;
    loading = widget.loading;
  }

  @override
  void didUpdateWidget(covariant BaseOtpVerificationBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.errorText != widget.errorText) {
      errorText = widget.errorText;
    }
    if (oldWidget.loading != widget.loading) {
      loading = widget.loading;
    }
  }

  @override
  void dispose() {
    otpCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonLabel = widget.buttonLabel;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignSpacingTokens.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.description),
          const SizedBox(height: DesignSpacingTokens.md),
          BaseOtpTextField(
            controller: otpCodeController,
            errorText: errorText,
            length: widget.otpLength,
          ),
          const SizedBox(height: DesignSpacingTokens.md),
          if (buttonLabel != null)
            BaseButton.primary(
              onPressed: loading
                  ? null
                  : () {
                      final otpCode = otpCodeController.text;
                      widget.onOtpSubmitted?.call(otpCode);
                    },
              label: buttonLabel,
              loading: loading,
            ),
        ],
      ),
    );
  }
}
