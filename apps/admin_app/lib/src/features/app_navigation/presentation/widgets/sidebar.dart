import 'package:admin_app/src/features/app_navigation/presentation/widgets/sidebar_account_menu.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/sidebar_item.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/sidebar_navigation_list.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    required this.pages,
    required this.onLogout,
    required this.onPageChanged,
    required this.onEditProfileTapped,
    required this.onNotificationsTapped,
    required this.onPreferencesTapped,
    required this.onDevicesTapped,
    super.key,
    this.selectedRoutePath,
    this.userEmail,
    this.userFullName,
    this.userAvatarUrl,
  });

  final List<SidebarItem> pages;
  final VoidCallback onLogout;
  final ValueChanged<String> onPageChanged;
  final String? selectedRoutePath;
  final VoidCallback onEditProfileTapped;
  final VoidCallback onNotificationsTapped;
  final VoidCallback onPreferencesTapped;
  final VoidCallback onDevicesTapped;
  final String? userEmail;
  final String? userFullName;
  final String? userAvatarUrl;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SizedBox(height: DesignSpacing.xl),
      const SizedBox(height: 70, child: FlutterLogo(size: 50)),
      Expanded(
        child: SidebarNavigationList(
          pages: pages,
          selectedRoutePath: selectedRoutePath,
          onPageChanged: onPageChanged,
        ),
      ),
      SidebarAccountMenu(
        baseUrl: context.di<CoreAppConfig>().baseUrl,
        userEmail: userEmail,
        userFullName: userFullName,
        userAvatarUrl: userAvatarUrl,
        onLogout: onLogout,
        onEditProfileTapped: onEditProfileTapped,
        onNotificationsTapped: onNotificationsTapped,
        onPreferencesTapped: onPreferencesTapped,
        onDevicesTapped: onDevicesTapped,
      ),
    ],
  );
}
