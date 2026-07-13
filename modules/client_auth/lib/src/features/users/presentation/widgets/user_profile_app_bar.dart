import 'dart:async';

import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:client_auth/src/features/users/presentation/widgets/user_avatar.dart';
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
          labelText: ClientAuthLocalizations.of(
            context,
          ).profileAvatarActionView,
          onTap: onViewAvatar,
          leading: const Icon(Icons.visibility),
        ),
      if (onChangeAvatar != null)
        BottomSheetListItem(
          labelText: ClientAuthLocalizations.of(
            context,
          ).profileAvatarActionChange,
          onTap: onChangeAvatar,
          leading: const Icon(Icons.edit),
        ),
      if (onRemoveAvatar != null)
        BottomSheetListItem(
          labelText: ClientAuthLocalizations.of(
            context,
          ).profileAvatarActionRemove,
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
            : Text(fullName!, style: context.textTheme.titleLarge),
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
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            UserAvatar(
              fullName: fullName ?? '',
              avatarUrl: avatarUrl,
              radius: 70,
              loading: avatarLoading,
              loadingProgress: avatarLoadingProgress,
              onTap: onAvatarTap,
            ),
            const SizedBox(height: 8),
            if (fullName != null)
              Text(fullName!, style: context.textTheme.titleLarge),
            if (email != null) ...[
              const SizedBox(height: 4),
              Text(
                email!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (phoneNumber != null) ...[
              const SizedBox(height: 4),
              Text(
                phoneNumber!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
