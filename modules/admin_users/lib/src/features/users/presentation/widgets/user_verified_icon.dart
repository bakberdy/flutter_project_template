import 'package:admin_users/src/common/presentation/extensions/admin_users_context_x.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class UserVerifiedIcon extends StatelessWidget {
  const UserVerifiedIcon({required this.verified, super.key});

  final bool verified;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = verified
        ? context.designColors.primary
        : context.designColors.onSurfaceVariant;

    return Tooltip(
      message: verified ? l10n.usersYes : l10n.usersNo,
      child: Icon(
        verified ? Icons.verified_outlined : Icons.cancel_outlined,
        color: color,
        size: 22,
      ),
    );
  }
}
