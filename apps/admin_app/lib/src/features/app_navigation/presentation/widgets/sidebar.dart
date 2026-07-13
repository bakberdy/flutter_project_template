import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/sidebar_item.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    required this.pages,
    super.key,
    this.onLogout,
    this.selectedRoutePath,
    this.onPageChanged,
    this.onEditProfileTapped,
    this.onNotificationsTapped,
    this.onPreferencesTapped,
    this.onDevicesTapped,
    this.userEmail,
    this.userFullName,
    this.userAvatarUrl,
  });

  final List<SidebarItem> pages;
  final VoidCallback? onLogout;
  final void Function(String routePath)? onPageChanged;
  final String? selectedRoutePath;
  final VoidCallback? onEditProfileTapped;
  final VoidCallback? onNotificationsTapped;
  final VoidCallback? onPreferencesTapped;
  final VoidCallback? onDevicesTapped;
  final String? userEmail;
  final String? userFullName;
  final String? userAvatarUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: DesignSpacing.xl),
        const SizedBox(height: 70, child: FlutterLogo(size: 50)),
        Expanded(
          child: ListView.builder(
            itemCount: pages.length,
            itemBuilder: (context, index) {
              final page = pages[index];
              final subItems = page.subItems;
              final isSelected = selectedRoutePath == page.routePath;
              if (subItems == null) {
                return ListTile(
                  shape: Border(
                    left: BorderSide(
                      color: isSelected
                          ? context.designColors.primary
                          : Colors.transparent,
                      width: 4,
                    ),
                  ),
                  title: Text(
                    page.name,
                    style: context.designTextTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? context.designColors.primary
                          : context.designColors.onSurface,
                    ),
                  ),
                  leading: page.icon,
                  selected: isSelected,
                  onTap: () {
                    final routePath = page.routePath;
                    if (routePath != null) {
                      onPageChanged?.call(routePath);
                    }
                  },
                );
              }

              return ExpansionTile(
                shape: Border(
                  left: BorderSide(
                    color: isSelected
                        ? context.designColors.primary
                        : Colors.transparent,
                    width: 4,
                  ),
                ),
                leading: page.icon,
                title: Text(
                  page.name,
                  style: context.designTextTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? context.designColors.primary
                        : context.designColors.onSurface,
                  ),
                ),
                children: subItems
                    .map(
                      (subPage) => Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: ListTile(
                          title: Text(subPage.name),
                          leading: subPage.icon,
                          onTap: () {
                            final routePath = subPage.routePath;
                            if (routePath != null) {
                              onPageChanged?.call(routePath);
                            }
                          },
                        ),
                      ),
                    )
                    .toList(growable: false),
              );
            },
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => MenuAnchor(
            crossAxisUnconstrained: false,
            style: MenuStyle(
              alignment: AlignmentDirectional.topStart,
              backgroundColor: WidgetStatePropertyAll(
                context.designColors.surfaceContainer,
              ),
              elevation: const WidgetStatePropertyAll(0),
              padding: const WidgetStatePropertyAll(EdgeInsets.zero),
              fixedSize: WidgetStatePropertyAll(
                Size.fromWidth(constraints.maxWidth),
              ),
              side: WidgetStatePropertyAll(
                BorderSide(color: context.designColors.outlineVariant),
              ),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(DesignRadii.md),
                  ),
                ),
              ),
            ),
            menuChildren: [
              Padding(
                padding: const EdgeInsets.all(DesignSpacing.md),
                child: Row(
                  children: [
                    UserAvatar(
                      fullName: userFullName,
                      avatarUrl: userAvatarUrl,
                      baseUrl: AppConfig.instance.baseUrl,
                      radius: 24,
                    ),
                    const SizedBox(width: DesignSpacing.sm),
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
                              style: context.designTextTheme.bodySmall
                                  ?.copyWith(
                                    color:
                                        context.designColors.onSurfaceVariant,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
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
              const Divider(height: 1),
              MenuItemButton(
                leadingIcon: Icon(
                  Icons.logout,
                  color: context.designColors.error,
                ),
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
                    ? const BorderRadius.vertical(
                        bottom: Radius.circular(DesignRadii.md),
                      )
                    : BorderRadius.circular(DesignRadii.md),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                onTap: controller.isOpen ? controller.close : controller.open,
                trailing: Icon(
                  controller.isOpen
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                ),
                leading: UserAvatar(
                  fullName: userFullName,
                  avatarUrl: userAvatarUrl,
                  baseUrl: AppConfig.instance.baseUrl,
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
        ),
      ],
    );
  }
}
