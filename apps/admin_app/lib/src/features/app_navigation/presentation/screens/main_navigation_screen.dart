import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/sidebar.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/sidebar_item.dart';
import 'package:admin_preferences/admin_preferences.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:admin_users/admin_users.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late final List<PageRouteInfo<dynamic>> _tabPageRoutes = [
    const AdminDashboardRoute(),
    adminUsersShellRoute(),
    const AdminInnerOneRoute(),
    const AdminInnerTwoRoute(),
  ];

  late final List<SidebarItem> _tabRoutes = [
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
    SidebarItem(
      name: context.l10n.moreExamples,
      icon: const Icon(Icons.home_outlined),
      subItems: [
        SidebarItem(
          name: context.l10n.innerItemOne,
          icon: const Icon(Icons.home_outlined),
          routePath: 'inner1',
        ),
        SidebarItem(
          name: context.l10n.innerItemTwo,
          icon: const Icon(Icons.home_outlined),
          routePath: 'inner2',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AutoTabsRouter(
      routes: _tabPageRoutes,
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        final userEmail = context.select<UserBloc, String?>(
          (bloc) => bloc.state.user?.email,
        );
        final profile = context.select<UserProfileBloc, UserProfile?>(
          (bloc) => bloc.state.profile,
        );

        return Material(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Sidebar(
                  userEmail: userEmail,
                  userFullName: profile?.fullName,
                  userAvatarUrl: profile?.avatarUrl,
                  onEditProfileTapped: () async {
                    await BaseDialog.show<void>(
                      context,
                      title: l10n.editProfile,
                      width: 600,
                      body: SizedBox(
                        height: 650,
                        width: 600,
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) =>
                                  context.di<UserProfileBloc>()
                                    ..add(const UserProfileEvent.started()),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  context.di<UserProfileEditBloc>(),
                            ),
                          ],
                          child: const UserProfileEditDialogView(),
                        ),
                      ),
                    );
                    if (context.mounted) {
                      context.read<UserProfileBloc>().add(
                        const UserProfileEvent.started(),
                      );
                    }
                  },
                  onNotificationsTapped: () => BaseDialog.show<void>(
                    context,
                    title: l10n.notifications,
                    width: 600,
                    body: const SizedBox(
                      height: 650,
                      width: 600,
                      child: NotificationsDialogView(),
                    ),
                  ),
                  onPreferencesTapped: () => BaseDialog.show<void>(
                    context,
                    title: l10n.preferences,
                    width: 600,
                    body: const SizedBox(
                      height: 650,
                      width: 600,
                      child: PreferencesDialogView(),
                    ),
                  ),
                  onDevicesTapped: () => BaseDialog.show<void>(
                    context,
                    title: l10n.devices,
                    width: 600,
                    body: const SizedBox(
                      height: 650,
                      width: 600,
                      child: DevicesDialogView(),
                    ),
                  ),
                  pages: _tabRoutes,
                  onPageChanged: (routePath) {
                    final index = _tabIndexForRoutePath(routePath);
                    if (index != null) {
                      tabsRouter.setActiveIndex(index);
                    }
                  },
                  selectedRoutePath: _routePathForTabIndex(
                    tabsRouter.activeIndex,
                  ),
                  onLogout: () => _onLogoutPressed(context),
                ),
              ),
              VerticalDivider(width: 1, color: context.designColors.outline),
              Expanded(
                flex: 5,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('main -> ${tabsRouter.current.path}'),
                    shape: Border(
                      bottom: BorderSide(color: context.designColors.outline),
                    ),
                  ),
                  body: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int? _tabIndexForRoutePath(String routePath) => switch (routePath) {
    'home' => 0,
    'users' => 1,
    'inner1' => 2,
    'inner2' => 3,
    _ => null,
  };

  String? _routePathForTabIndex(int index) => switch (index) {
    0 => 'home',
    1 => 'users',
    2 => 'inner1',
    3 => 'inner2',
    _ => null,
  };

  Future<void> _onLogoutPressed(BuildContext context) async {
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
        const CoreNavigationEvent.unAuthenticated(),
      );
    }
  }
}
