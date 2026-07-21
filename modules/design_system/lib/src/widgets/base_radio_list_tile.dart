import 'package:design_system/src/widgets/base_list_tile.dart';
import 'package:flutter/material.dart';

class BaseRadioListTile<T> extends StatelessWidget {
  const BaseRadioListTile({
    required this.title,
    required this.value,
    super.key,
    this.subtitle,
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
    return BaseListTile(
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
