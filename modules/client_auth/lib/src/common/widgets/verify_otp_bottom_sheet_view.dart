import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class VerifyOtpBottomSheetView extends StatefulWidget {
  const VerifyOtpBottomSheetView({
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
  State<VerifyOtpBottomSheetView> createState() =>
      _VerifyOtpBottomSheetViewState();
}

class _VerifyOtpBottomSheetViewState extends State<VerifyOtpBottomSheetView> {
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
  void didUpdateWidget(covariant VerifyOtpBottomSheetView oldWidget) {
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
      padding: const EdgeInsets.symmetric(horizontal: DesignSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.description),
          const SizedBox(height: DesignSpacing.md),
          BaseOtpTextField(
            controller: otpCodeController,
            errorText: errorText,
            length: widget.otpLength,
          ),
          const SizedBox(height: DesignSpacing.md),
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
