import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_phone_number.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:admin_users/src/features/users/presentation/extensions/admin_user_localization_x.dart';
import 'package:admin_users/src/features/users/presentation/widgets/user_actions.dart';
import 'package:admin_users/src/features/users/presentation/widgets/user_header_card.dart';
import 'package:admin_users/src/features/users/presentation/widgets/user_info_card.dart';
import 'package:admin_users/gen/l10n/admin_users_localizations.dart';
import 'package:admin_users/src/common/admin_users_context_x.dart';

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({
    super.key,
    required this.user,
    required this.profile,
    required this.actionLoading,
    required this.onApproveDeletionRequest,
    required this.onBlockUser,
    required this.onUnblockUser,
  });

  final AdminUser user;
  final AdminUserProfile? profile;
  final bool actionLoading;
  final VoidCallback onApproveDeletionRequest;
  final VoidCallback onBlockUser;
  final VoidCallback onUnblockUser;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dateFormat = DateFormat.yMd(l10n.localeName).add_Hm();
    final profile = this.profile;
    final completedAt = profile?.completedAt;
    final hasActions = user.status != AdminUserStatus.deleted;
    final userCard = UserInfoCard(
      title: l10n.userCardTitle,
      rows: [
        InfoRow(label: l10n.userId, value: user.id),
        InfoRow(label: l10n.usersColumnEmail, value: user.email),
        InfoRow(
          label: l10n.usersColumnRole,
          value: user.role.localizedName(l10n),
        ),
        InfoRow(
          label: l10n.usersColumnVerified,
          value: user.isVerified ? l10n.usersYes : l10n.usersNo,
          showCopyIcon: false,
        ),
        InfoRow(
          label: l10n.usersColumnProfileCompleted,
          value: user.isUserDataUploaded ? l10n.usersYes : l10n.usersNo,
          showCopyIcon: false,
        ),
        InfoRow(
          label: l10n.usersColumnCreatedAt,
          value: dateFormat.format(user.createdAt.toLocal()),
          showCopyIcon: false,
        ),
      ],
    );
    final profileCard = profile == null
        ? null
        : UserInfoCard(
            title: l10n.userProfileCardTitle,
            rows: [
              InfoRow(label: l10n.userProfileFullName, value: profile.fullName),
              InfoRow(
                label: l10n.userProfilePhone,
                value: _phone(profile.phoneNumber, l10n),
              ),
              InfoRow(
                label: l10n.userProfileAvatar,
                value: profile.avatarUrl == null ? l10n.usersNo : l10n.usersYes,
                showCopyIcon: false,
              ),
              InfoRow(
                label: l10n.userProfileCreatedAt,
                value: dateFormat.format(profile.createdAt.toLocal()),
                showCopyIcon: false,
              ),
              InfoRow(
                label: l10n.userProfileUpdatedAt,
                value: dateFormat.format(profile.updatedAt.toLocal()),
                showCopyIcon: false,
              ),
              InfoRow(
                label: l10n.userProfileCompletedAt,
                value: completedAt == null
                    ? l10n.usersNo
                    : dateFormat.format(completedAt.toLocal()),
                showCopyIcon: false,
              ),
            ],
          );

    return SelectionArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserHeaderCard(user: user, profile: profile),
            if (hasActions) ...[
              const SizedBox(height: DesignSpacingTokens.md),
              UserActions(
                user: user,
                loading: actionLoading,
                onApproveDeletionRequest: onApproveDeletionRequest,
                onBlockUser: onBlockUser,
                onUnblockUser: onUnblockUser,
              ),
            ],
            const SizedBox(height: DesignSpacingTokens.md),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: userCard),
                if (profileCard != null) ...[
                  const SizedBox(width: DesignSpacingTokens.md),
                  Expanded(child: profileCard),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _phone(
    AdminUserPhoneNumber? phoneNumber,
    AdminUsersLocalizations l10n,
  ) {
    if (phoneNumber == null) {
      return l10n.usersNo;
    }
    return '${phoneNumber.dialCode} ${phoneNumber.number}';
  }
}
