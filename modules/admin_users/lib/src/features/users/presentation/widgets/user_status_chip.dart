import 'package:admin_users/src/common/presentation/extensions/admin_users_context_x.dart';
import 'package:admin_users/src/features/users/presentation/extensions/admin_user_localization_x.dart';
import 'package:admin_users/src/features/users/presentation/extensions/admin_user_status_x.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class UserStatusChip extends StatelessWidget {
  const UserStatusChip({required this.status, super.key});

  final UserStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color;

    return Chip(
      side: BorderSide.none,
      backgroundColor: color.withValues(alpha: 0.12),
      label: Text(
        status.localizedName(context.l10n),
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
      avatar: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
