import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SidebarAccountMenu extends StatelessWidget {
  const SidebarAccountMenu({
    required this.baseUrl,
    required this.onLogout,
    required this.onEditProfileTapped,
    required this.onNotificationsTapped,
    required this.onPreferencesTapped,
    required this.onDevicesTapped,
    super.key,
    this.userEmail,
    this.userFullName,
    this.userAvatarUrl,
  });

  final String baseUrl;
  final VoidCallback onLogout;
  final VoidCallback onEditProfileTapped;
  final VoidCallback onNotificationsTapped;
  final VoidCallback onPreferencesTapped;
  final VoidCallback onDevicesTapped;
  final String? userEmail;
  final String? userFullName;
  final String? userAvatarUrl;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => MenuAnchor(
      crossAxisUnconstrained: false,
      style: MenuStyle(
        alignment: AlignmentDirectional.topStart,
        backgroundColor: WidgetStatePropertyAll(
          context.designColors.surfaceContainer,
        ),
        elevation: WidgetStatePropertyAll(0),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        fixedSize: WidgetStatePropertyAll(Size.fromWidth(constraints.maxWidth)),
        side: WidgetStatePropertyAll(
          BorderSide(color: context.designColors.outlineVariant),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(context.designRadii.md),
            ),
          ),
        ),
      ),
      menuChildren: [
        Padding(
          padding: EdgeInsets.all(context.designSpacing.md),
          child: Row(
            children: [
              UserAvatar(
                fullName: userFullName,
                avatarUrl: userAvatarUrl,
                baseUrl: baseUrl,
                radius: 24,
              ),
              SizedBox(width: context.designSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (userFullName case final fullName?)
                      Text(
                        fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.designTextTheme.titleSmall,
                      ),
                    if (userEmail case final email?)
                      Text(
                        email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.designTextTheme.bodySmall?.copyWith(
                          color: context.designColors.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1),
        MenuItemButton(
          leadingIcon: const Icon(Icons.edit_outlined),
          onPressed: onEditProfileTapped,
          child: Text(context.l10n.editProfile),
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.notifications_outlined),
          onPressed: onNotificationsTapped,
          child: Text(context.l10n.notifications),
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.settings_outlined),
          onPressed: onPreferencesTapped,
          child: Text(context.l10n.preferences),
        ),
        MenuItemButton(
          leadingIcon: const Icon(Icons.devices_outlined),
          onPressed: onDevicesTapped,
          child: Text(context.l10n.devices),
        ),
        Divider(height: 1),
        MenuItemButton(
          leadingIcon: Icon(Icons.logout, color: context.designColors.error),
          onPressed: onLogout,
          child: Text(
            context.l10n.logout,
            style: TextStyle(color: context.designColors.error),
          ),
        ),
      ],
      builder: (context, controller, child) => Material(
        color: context.designColors.surfaceContainer,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: context.designColors.outlineVariant),
          borderRadius: controller.isOpen
              ? BorderRadius.vertical(
                  bottom: Radius.circular(context.designRadii.md),
                )
              : BorderRadius.circular(context.designRadii.md),
        ),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: controller.isOpen ? controller.close : controller.open,
          trailing: Icon(
            controller.isOpen ? Icons.arrow_drop_down : Icons.arrow_drop_up,
          ),
          leading: UserAvatar(
            fullName: userFullName,
            avatarUrl: userAvatarUrl,
            baseUrl: baseUrl,
            radius: 18,
          ),
          title: Text(
            userEmail ?? context.l10n.editProfile,
            style: context.designTextTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.designColors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    ),
  );
}
