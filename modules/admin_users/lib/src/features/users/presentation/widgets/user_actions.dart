import 'package:admin_users/src/common/admin_users_context_x.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class UserActions extends StatelessWidget {
  const UserActions({
    required this.user,
    required this.loading,
    required this.onApproveDeletionRequest,
    required this.onBlockUser,
    required this.onUnblockUser,
    super.key,
  });

  final AdminUser user;
  final bool loading;
  final VoidCallback onApproveDeletionRequest;
  final VoidCallback onBlockUser;
  final VoidCallback onUnblockUser;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canApproveDeletion = user.status == AdminUserStatus.deletionRequested;
    final canBlock =
        user.status != AdminUserStatus.blocked &&
        user.status != AdminUserStatus.deleted;
    final canUnblock = user.status == AdminUserStatus.blocked;

    if (!canApproveDeletion && !canBlock && !canUnblock) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: DesignSpacingTokens.sm,
      runSpacing: DesignSpacingTokens.sm,
      children: [
        if (canApproveDeletion)
          BaseButton.destructive(
            onPressed: onApproveDeletionRequest,
            loading: loading,
            label: l10n.userActionApproveDeletionRequest,
            leadingIcon: const Icon(Icons.delete_outline),
          ),
        if (canBlock)
          BaseButton.destructive(
            onPressed: onBlockUser,
            loading: loading,
            label: l10n.userActionBlock,
            leadingIcon: const Icon(Icons.block_outlined),
          ),
        if (canUnblock)
          BaseButton.secondary(
            onPressed: onUnblockUser,
            loading: loading,
            label: l10n.userActionUnblock,
            leadingIcon: const Icon(Icons.lock_open_outlined),
          ),
      ],
    );
  }
}
