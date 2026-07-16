import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:admin_users/src/features/users/presentation/extensions/admin_user_localization_x.dart';
import 'package:admin_users/src/features/users/presentation/widgets/user_status_card.dart';
import 'package:admin_users/src/common/admin_users_context_x.dart';

class UserHeaderCard extends StatelessWidget {
  const UserHeaderCard({super.key, required this.user, required this.profile});

  final AdminUser user;
  final AdminUserProfile? profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final displayName = profile?.fullName.trim();
    final title = displayName == null || displayName.isEmpty
        ? user.email
        : displayName;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.designRadii.sm),
        side: BorderSide(color: context.designColors.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.designSpacing.lg),
        child: Row(
          children: [
            UserAvatar(
              fullName: title,
              avatarUrl: profile?.avatarUrl,
              radius: 42,
              format: UserAvatarFormat.square,
            ),
            SizedBox(width: context.designSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.designTextTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: context.designSpacing.xs),
                  SelectableText(
                    user.email,
                    style: context.designTextTheme.bodyLarge?.copyWith(
                      color: context.designColors.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: context.designSpacing.sm),
                  Wrap(
                    spacing: context.designSpacing.sm,
                    runSpacing: context.designSpacing.xs,
                    children: [
                      UserStatusChip(status: user.status),
                      Chip(
                        label: Text(user.role.localizedName(l10n)),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide.none,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
