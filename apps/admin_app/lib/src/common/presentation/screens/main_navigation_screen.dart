import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_app/src/common/presentation/widgets/sidebar.dart';
import 'package:admin_app/src/common/presentation/widgets/sidebar_item.dart';
import 'package:admin_auth/admin_auth.dart';
import 'package:admin_preferences/admin_preferences.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:admin_users/admin_users.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainNavigationScreen extends StatelessWidget implements AutoRouteWrapper {
  const MainNavigationScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
    create: (context) =>
        context.di<UserProfileBloc>()..add(const UserProfileEvent.started()),
    child: this,
  );

  @override
  Widget build(BuildContext context) => AutoTabsRouter(
    routes: [const AdminDashboardRoute(), adminUsersShellRoute()],
    builder: (context, child) {
      final tabsRouter = context.tabsRouter;
      final userEmail = context.select<AdminSessionBloc, String?>(
        (bloc) => bloc.state.user?.email,
      );
      final profile = context.select<UserProfileBloc, UserProfile?>(
        (bloc) => bloc.state.profile,
      );

      return Scaffold(
        body: Row(
          children: [
            SizedBox(
              width: 280,
              child: Sidebar(
                userEmail: userEmail,
                userFullName: profile?.fullName,
                userAvatarUrl: profile?.avatarUrl,
                onEditProfileTapped: () => _showEditProfileDialog(context),
                onNotificationsTapped: () => BaseDialog.show<void>(
                  context,
                  title: context.l10n.notifications,
                  width: 600,
                  height: 650,
                  body: const NotificationsDialogView(),
                ),
                onPreferencesTapped: () => BaseDialog.show<void>(
                  context,
                  title: context.l10n.preferences,
                  width: 600,
                  height: 650,
                  body: const PreferencesDialogView(),
                ),
                onDevicesTapped: () => BaseDialog.show<void>(
                  context,
                  title: context.l10n.devices,
                  width: 600,
                  height: 650,
                  body: const DevicesDialogView(),
                ),
                pages: [
                  SidebarItem(
                    name: context.l10n.dashboard,
                    icon: const Icon(Icons.home_outlined),
                    routePath: 'home',
                  ),
                  SidebarItem(
                    name: context.l10n.users,
                    icon: const Icon(Icons.people_outline),
                    routePath: 'users',
                  ),
                ],
                onPageChanged: (routePath) {
                  final index = switch (routePath) {
                    'home' => 0,
                    'users' => 1,
                    _ => null,
                  };
                  if (index != null) {
                    tabsRouter.setActiveIndex(index);
                  }
                },
                selectedRoutePath: switch (tabsRouter.activeIndex) {
                  0 => 'home',
                  1 => 'users',
                  _ => null,
                },
                onLogout: () => _showLogoutDialog(context),
              ),
            ),
            VerticalDivider(width: 1, color: context.designColors.outline),
            Expanded(child: child),
          ],
        ),
      );
    },
  );

  Future<void> _showEditProfileDialog(BuildContext context) async {
    await BaseDialog.show<void>(
      context,
      title: context.l10n.editProfile,
      width: 600,
      height: 650,
      body: const UserProfileEditView(),
    );
    if (context.mounted) {
      context.read<UserProfileBloc>().add(const UserProfileEvent.started());
    }
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    final accepted = await BaseDialog.show<bool>(
      context,
      title: context.l10n.logoutTitle,
      description: context.l10n.logoutMessage,
      primaryLabel: context.l10n.logout,
      secondaryLabel: context.l10n.cancel,
      primaryValue: true,
      secondaryValue: false,
      primaryFirst: true,
    );
    if ((accepted ?? false) && context.mounted) {
      context.router.markUrlStateForReplace();
      context.read<CoreNavigationBloc>().add(
        const CoreNavigationEvent.loggedOut(),
      );
    }
  }
}
