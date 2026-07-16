import 'package:design_system/src/tokens/design_tokens.dart';
import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:design_system/src/inputs/phone/country_dial_code_option.dart';
import 'package:flutter/material.dart';

class BaseCountryDialCodePrefixButton extends StatelessWidget {
  const BaseCountryDialCodePrefixButton({
    super.key,
    required this.dialCode,
    required this.onTap,
  });

  final CountryDialCodeOption dialCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          countryDialCodeFlag(context, dialCode),
          SizedBox(width: DesignTokens.spacing.xs),
          Text('${dialCode.dialCode} '),
        ],
      ),
    );
  }
}

Widget countryDialCodeFlag(
  BuildContext context,
  CountryDialCodeOption dialCode,
) {
  final flags = context.designAssets.icons.countryFlags;
  return switch (dialCode.countryCode) {
    'KZ' => flags.kazakhstan.image(
      width: 24,
      height: 24,
      errorBuilder: (context, error, stackTrace) =>
          SizedBox(width: 24, height: 24),
    ),
    'RU' => flags.russia.image(
      width: 24,
      height: 24,
      errorBuilder: (context, error, stackTrace) =>
          SizedBox(width: 24, height: 24),
    ),
    'US' => flags.unitedStates.image(
      width: 24,
      height: 24,
      errorBuilder: (context, error, stackTrace) =>
          SizedBox(width: 24, height: 24),
    ),
    'GB' => flags.unitedKingdom.image(
      width: 24,
      height: 24,
      errorBuilder: (context, error, stackTrace) =>
          SizedBox(width: 24, height: 24),
    ),
    _ => SizedBox(width: 24, height: 24),
  };
}
