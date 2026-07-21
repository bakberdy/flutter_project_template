import 'package:design_system/src/extensions/build_context_design_x.dart';
import 'package:design_system/src/extensions/design_system_localization_x.dart';
import 'package:design_system/src/inputs/phone/base_country_dial_code_prefix_button.dart';
import 'package:design_system/src/inputs/phone/country_dial_code_option.dart';
import 'package:design_system/src/tokens/design_tokens.dart';
import 'package:flutter/material.dart';

class BaseCountryDialCodeSelectorOverlay {
  OverlayEntry? _entry;

  bool get isVisible => _entry?.mounted ?? false;

  void show({
    required BuildContext context,
    required LayerLink layerLink,
    required List<CountryDialCodeOption> dialCodes,
    required ValueChanged<CountryDialCodeOption> onSelected,
  }) {
    if (isVisible) {
      return;
    }

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => BaseCountryDialCodeSelector(
        layerLink: layerLink,
        dialCodes: dialCodes,
        onDismiss: hide,
        onSelected: (value) {
          close();
          onSelected(value);
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

class BaseCountryDialCodeSelector extends StatelessWidget {
  const BaseCountryDialCodeSelector({
    required this.dialCodes,
    required this.layerLink,
    required this.onDismiss,
    required this.onSelected,
    super.key,
  });

  final List<CountryDialCodeOption> dialCodes;
  final LayerLink layerLink;
  final VoidCallback onDismiss;
  final ValueChanged<CountryDialCodeOption> onSelected;

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
                  color: context.designColors.surface,
                  borderRadius: BorderRadius.circular(DesignRadiusTokens.sm),
                ),
                height: 200,
                width: 150,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: dialCodes
                      .map(
                        (dialCode) => InkWell(
                          onTap: () => onSelected(dialCode),
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DesignSpacingTokens.md,
                              vertical: DesignSpacingTokens.sm,
                            ),
                            child: Row(
                              children: [
                                countryDialCodeFlag(context, dialCode),
                                const SizedBox(width: DesignSpacingTokens.xs),
                                Text(
                                  context.designL10n.countryDialCodeOption(
                                    dialCode.dialCode,
                                    dialCode.countryCode,
                                  ),
                                  style: context.designTextTheme.bodyLarge,
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
