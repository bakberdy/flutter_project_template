import 'dart:async';

import 'package:client_profile/src/common/client_profile_context_x.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class UserProfileAppBar extends StatelessWidget {
  const UserProfileAppBar({
    super.key,
    required this.fullName,
    this.onShare,
    this.onEdit,
    this.onViewAvatar,
    this.onChangeAvatar,
    this.onRemoveAvatar,
    this.email,
    this.phoneNumber,
    this.avatarUrl,
    this.avatarLoading = false,
    this.avatarLoadingProgress,
  });

  final String? fullName;
  final VoidCallback? onShare;
  final VoidCallback? onEdit;
  final VoidCallback? onViewAvatar;
  final VoidCallback? onChangeAvatar;
  final VoidCallback? onRemoveAvatar;
  final String? email;
  final String? phoneNumber;
  final String? avatarUrl;
  final bool avatarLoading;
  final double? avatarLoadingProgress;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      leading: IconButton(icon: const Icon(Icons.share), onPressed: onShare),
      actions: [IconButton(icon: const Icon(Icons.edit), onPressed: onEdit)],
      expandedHeight: 200,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = MediaQuery.paddingOf(context).top;
          final collapsedHeight = kToolbarHeight + topPadding;
          final isCollapsed = constraints.maxHeight <= collapsedHeight + 20;

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: isCollapsed
                ? CollapsedTitle(
                    key: const ValueKey('collapsed_name'),
                    fullName: fullName,
                  )
                : ExpandedHeader(
                    key: const ValueKey('expanded_avatar'),
                    fullName: fullName,
                    avatarUrl: avatarUrl,
                    avatarLoading: avatarLoading,
                    avatarLoadingProgress: avatarLoadingProgress,
                    onAvatarTap: _hasAvatarActions
                        ? () => _showAvatarOptions(context)
                        : null,
                    email: email,
                    phoneNumber: phoneNumber,
                  ),
          );
        },
      ),
    );
  }

  bool get _hasAvatarActions =>
      onViewAvatar != null || onChangeAvatar != null || onRemoveAvatar != null;

  Future<void> _showAvatarOptions(BuildContext context) async {
    final items = [
      if (onViewAvatar != null)
        BottomSheetListItem(
          labelText: context.l10n.profileAvatarActionView,
          onTap: onViewAvatar,
          leading: const Icon(Icons.visibility),
        ),
      if (onChangeAvatar != null)
        BottomSheetListItem(
          labelText: context.l10n.profileAvatarActionChange,
          onTap: onChangeAvatar,
          leading: const Icon(Icons.edit),
        ),
      if (onRemoveAvatar != null)
        BottomSheetListItem(
          labelText: context.l10n.profileAvatarActionRemove,
          onTap: onRemoveAvatar,
          leading: const Icon(Icons.delete),
        ),
    ];

    await BaseBottomSheet.showList(
      rootNavigator: true,
      routeName: 'avatar_options_bottom_sheet',
      context: context,
      divider: const SizedBox.shrink(),
      items: items,
    );
  }
}

class CollapsedTitle extends StatelessWidget {
  const CollapsedTitle({super.key, required this.fullName});

  final String? fullName;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: fullName == null
            ? const SizedBox.shrink()
            : Text(fullName!, style: context.designTextTheme.titleLarge),
      ),
    );
  }
}

class ExpandedHeader extends StatelessWidget {
  const ExpandedHeader({
    super.key,
    required this.fullName,
    this.avatarUrl,
    this.avatarLoading = false,
    this.avatarLoadingProgress,
    this.onAvatarTap,
    this.email,
    this.phoneNumber,
  });

  final String? fullName;
  final String? avatarUrl;
  final bool avatarLoading;
  final double? avatarLoadingProgress;
  final VoidCallback? onAvatarTap;
  final String? email;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          UserAvatar(
            fullName: fullName ?? '',
            avatarUrl: avatarUrl,
            baseUrl: context.di<CoreAppConfig>().baseUrl,
            radius: 70,
            loading: avatarLoading,
            loadingProgress: avatarLoadingProgress,
            onTap: onAvatarTap,
          ),
          const SizedBox(height: 8),
          if (fullName != null)
            Flexible(
              child: Text(
                fullName!,
                style: context.designTextTheme.titleLarge?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
          if (email != null) ...[
            const SizedBox(height: 4),
            Text(
              email!,
              style: context.designTextTheme.bodyMedium?.copyWith(
                color: context.designColors.onSurfaceVariant,
              ),
            ),
          ],
          if (phoneNumber != null) ...[
            const SizedBox(height: 4),
            Text(
              phoneNumber!,
              style: context.designTextTheme.bodyMedium?.copyWith(
                color: context.designColors.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
