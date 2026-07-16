import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:design_system/src/inputs/base_input_field.dart';
import 'package:design_system/src/inputs/phone/base_country_dial_code_prefix_button.dart';
import 'package:design_system/src/inputs/phone/base_phone_number_input_formatter.dart';
import 'package:design_system/src/inputs/phone/country_dial_code_option.dart';
import 'package:design_system/src/tokens/design_tokens.dart';
import 'package:flutter/material.dart';

class BasePhoneNumberTextField extends StatelessWidget {
  const BasePhoneNumberTextField({
    super.key,
    required this.controller,
    required this.layerLink,
    required this.labelText,
    required this.dialCode,
    required this.onCountryCodeTap,
    this.maxDigits = 10,
    this.showVerificationPrompt = false,
    this.showVerified = false,
    this.verifiedLabel,
    this.verificationPromptLabel,
    this.verifyActionLabel,
    this.onVerifyTap,
    this.onChanged,
    this.errorText,
  });

  final TextEditingController controller;
  final LayerLink layerLink;
  final String labelText;
  final CountryDialCodeOption? dialCode;
  final VoidCallback onCountryCodeTap;
  final int maxDigits;
  final VoidCallback? onVerifyTap;
  final ValueChanged<String>? onChanged;
  final bool showVerificationPrompt;
  final bool showVerified;
  final String? verifiedLabel;
  final String? verificationPromptLabel;
  final String? verifyActionLabel;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        children: [
          BaseInputField(
            label: labelText,
            controller: controller,
            onChanged: onChanged,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              BasePhoneNumberInputFormatter(maxDigits: maxDigits),
            ],
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.phone),
              prefix: dialCode == null
                  ? const SizedBox.shrink()
                  : BaseCountryDialCodePrefixButton(
                      dialCode: dialCode!,
                      onTap: onCountryCodeTap,
                    ),
              prefixStyle: context.designTextTheme.bodyLarge?.copyWith(),
            ),
            errorText: errorText,
          ),
          if (showVerificationPrompt || showVerified)
            Padding(
              padding: const EdgeInsets.only(top: DesignSpacingTokens.xs),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showVerified) ...[
                      Icon(
                        Icons.verified,
                        size: 16,
                        color: context.designColors.primary,
                      ),
                      const SizedBox(width: DesignSpacingTokens.xxs),
                      Text(
                        verifiedLabel ?? '',
                        style: context.designTextTheme.bodySmall?.copyWith(
                          color: context.designColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    if (showVerificationPrompt) ...[
                      Text(
                        verificationPromptLabel ?? '',
                        style: context.designTextTheme.bodySmall,
                      ),
                      const SizedBox(width: DesignSpacingTokens.xxs),
                      TextButton(
                        onPressed: onVerifyTap,
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          verifyActionLabel ?? '',
                          style: context.designTextTheme.bodySmall?.copyWith(
                            color: context.designColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
