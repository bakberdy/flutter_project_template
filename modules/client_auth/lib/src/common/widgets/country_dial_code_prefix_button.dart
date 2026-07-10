import 'package:design_system/design_system.dart';
import 'package:client_auth/src/common/client_auth_context_x.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CountryDialCodePrefixButton extends StatelessWidget {
  const CountryDialCodePrefixButton({
    super.key,
    required this.dialCode,
    required this.onTap,
  });

  final CountryDialCode dialCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _countryFlag(context, dialCode),
          const SizedBox(width: DesignSpacing.xs),
          Text('${dialCode.dialCode} '),
        ],
      ),
    );
  }
}

Widget _countryFlag(BuildContext context, CountryDialCode dialCode) {
  final flags = context.assets.icons.countryFlags;
  return switch (dialCode.countryCode) {
    'KZ' => flags.kazakhstan.image(
      width: 24,
      height: 24,
      errorBuilder: (context, error, stackTrace) =>
          const SizedBox(width: 24, height: 24),
    ),
    'RU' => flags.russia.image(
      width: 24,
      height: 24,
      errorBuilder: (context, error, stackTrace) =>
          const SizedBox(width: 24, height: 24),
    ),
    'US' => flags.unitedStates.image(
      width: 24,
      height: 24,
      errorBuilder: (context, error, stackTrace) =>
          const SizedBox(width: 24, height: 24),
    ),
    'GB' => flags.unitedKingdom.image(
      width: 24,
      height: 24,
      errorBuilder: (context, error, stackTrace) =>
          const SizedBox(width: 24, height: 24),
    ),
    _ => const SizedBox(width: 24, height: 24),
  };
}
