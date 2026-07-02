import 'package:design_system/src/widgets/app_item_card.dart';
import 'package:flutter/material.dart';

class AppRadioListTile<T> extends StatelessWidget {
  const AppRadioListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    this.icon,
    this.loading = false,
    this.disableTopRadius = false,
    this.disableBottomRadius = false,
  });

  final String title;
  final String? subtitle;
  final T value;
  final Widget? icon;
  final bool loading;
  final bool disableTopRadius;
  final bool disableBottomRadius;

  @override
  Widget build(BuildContext context) {
    return AppItemCard(
      onTap: loading
          ? () {}
          : () {
              RadioGroup.maybeOf<T>(context)?.onChanged(value);
            },
      title: title,
      subtitle: subtitle,
      trailing: loading
          ? const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : icon,
      disableBottomRadius: disableBottomRadius,
      disableTopRadius: disableTopRadius,
    );
  }
}
