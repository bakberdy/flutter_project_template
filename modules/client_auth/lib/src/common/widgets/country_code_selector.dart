import 'package:design_system/design_system.dart';
import 'package:client_auth/src/common/client_auth_context_x.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CountryCodeSelectorOverlay {
  OverlayEntry? _entry;

  bool get isVisible => _entry?.mounted ?? false;

  void show({
    required BuildContext context,
    required LayerLink layerLink,
    required List<CountryDialCode> dialCodesByCountryCode,
    required ValueChanged<CountryDialCode> onCountryCodeSelected,
  }) {
    if (isVisible) {
      return;
    }

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => CountryCodeSelector(
        layerLink: layerLink,
        dialCodesByCountryCode: dialCodesByCountryCode,
        onDismiss: hide,
        onCountryCodeSelected: (value) {
          close();
          onCountryCodeSelected(value);
        },
      ),
    );
    _entry = entry;
    Overlay.of(context).insert(entry);
  }

  void hide() {
    final entry = _entry;
    if (entry?.mounted ?? false) {
      entry!.remove();
    }
    _entry = null;
  }

  void close() {
    hide();
  }
}

class CountryCodeSelector extends StatelessWidget {
  const CountryCodeSelector({
    super.key,
    required this.dialCodesByCountryCode,
    required this.layerLink,
    required this.onDismiss,
    required this.onCountryCodeSelected,
  });

  final List<CountryDialCode> dialCodesByCountryCode;
  final LayerLink layerLink;
  final VoidCallback onDismiss;
  final ValueChanged<CountryDialCode> onCountryCodeSelected;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onDismiss,
        child: Material(
          color: Colors.transparent,
          child: Align(
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 50),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(DesignRadii.sm),
                ),
                height: 200,
                width: 150,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: dialCodesByCountryCode
                      .map(
                        (dialCode) => InkWell(
                          onTap: () => onCountryCodeSelected(dialCode),
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DesignSpacing.md,
                              vertical: DesignSpacing.sm,
                            ),
                            child: Row(
                              children: [
                                _countryFlag(context, dialCode),
                                const SizedBox(width: DesignSpacing.xs),
                                Text(
                                  '${dialCode.dialCode} (${dialCode.countryCode})',
                                  style: context.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
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
