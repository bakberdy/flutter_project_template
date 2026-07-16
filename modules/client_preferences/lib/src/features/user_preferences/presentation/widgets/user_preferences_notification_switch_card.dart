import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class UserPreferencesNotificationSwitchCard extends StatelessWidget {
  const UserPreferencesNotificationSwitchCard({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.loading = false,
    this.disableTopRadius = false,
    this.disableBottomRadius = false,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool loading;
  final bool disableTopRadius;
  final bool disableBottomRadius;

  @override
  Widget build(BuildContext context) {
    return BaseListTile(
      padding: EdgeInsets.symmetric(
        horizontal: context.designSpacing.sm,
        vertical: context.designSpacing.xs,
      ),
      onTap: loading ? () {} : () => onChanged(!value),
      title: title,
      trailing: Switch.adaptive(
        value: value,
        onChanged: loading ? null : onChanged,
      ),
      disableTopRadius: disableTopRadius,
      disableBottomRadius: disableBottomRadius,
    );
  }
}
