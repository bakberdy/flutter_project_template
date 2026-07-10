import 'package:design_system/design_system.dart';
import 'package:client_auth/src/common/client_auth_context_x.dart';
import 'package:core/core.dart';
import 'package:client_auth/src/common/inputs/phone_number_input_formatter.dart';
import 'package:client_auth/src/common/widgets/country_dial_code_prefix_button.dart';
import 'package:flutter/material.dart';

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    super.key,
    required this.controller,
    required this.layerLink,
    required this.dialCode,
    required this.onCountryCodeTap,
    this.maxDigits = 10,
    this.showVerificationPrompt = false,
    this.showVerified = false,
    this.onVerifyTap,
    this.onChanged,
    this.errorText,
  });

  final TextEditingController controller;
  final LayerLink layerLink;
  final CountryDialCode? dialCode;
  final VoidCallback onCountryCodeTap;
  final int maxDigits;
  final VoidCallback? onVerifyTap;
  final ValueChanged<String>? onChanged;
  final bool showVerificationPrompt;
  final bool showVerified;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        children: [
          TextField(
            controller: controller,
            onChanged: onChanged,
            textInputAction: TextInputAction.done,
            inputFormatters: [PhoneNumberInputFormatter(maxDigits: maxDigits)],
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: context.l10n.profileEditPhoneNumberLabel,
              prefixIcon: const Icon(Icons.phone),
              prefix: dialCode == null
                  ? const SizedBox.shrink()
                  : CountryDialCodePrefixButton(
                      dialCode: dialCode!,
                      onTap: onCountryCodeTap,
                    ),
              prefixStyle: context.textTheme.bodyLarge?.copyWith(),
              errorText: errorText,
            ),
          ),
          if (showVerificationPrompt || showVerified)
            Padding(
              padding: const EdgeInsets.only(top: DesignSpacing.xs),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showVerified) ...[
                      Icon(
                        Icons.verified,
                        size: 16,
                        color: context.colorScheme.primary,
                      ),
                      const SizedBox(width: DesignSpacing.xxs),
                      Text(
                        context.l10n.profileEditPhoneVerified,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    if (showVerificationPrompt) ...[
                      Text(
                        context.l10n.profileEditPhoneVerificationPrompt,
                        style: context.textTheme.bodySmall,
                      ),
                      const SizedBox(width: DesignSpacing.xxs),
                      TextButton(
                        onPressed: onVerifyTap,
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          context.l10n.profileEditVerifyNow,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.primary,
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
