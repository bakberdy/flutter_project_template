import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/sidebar.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/sidebar_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) => AutoTabsRouter(
    builder: (context, child) {
      final tabsRouter = context.tabsRouter;
      final l10n = context.l10n;
      return Scaffold(
        body: Row(
          children: [
            Sidebar(
              selectedIndex: tabsRouter.activeIndex,
              onItemSelected: tabsRouter.setActiveIndex,
              onLogout: () => context.read<CoreNavigationBloc>().add(
                const CoreNavigationEvent.unAuthenticated(),
              ),
              items: [
                SidebarItem(
                  icon: Icons.dashboard_outlined,
                  selectedIcon: Icons.dashboard,
                  label: l10n.dashboard,
                ),
                SidebarItem(
                  icon: Icons.people_outline,
                  selectedIcon: Icons.people,
                  label: l10n.users,
                ),
                SidebarItem(
                  icon: Icons.settings_outlined,
                  selectedIcon: Icons.settings,
                  label: l10n.settings,
                ),
              ],
            ),
            const VerticalDivider(width: 1, thickness: 1),
            Expanded(child: child),
          ],
        ),
      );
    },
  );
}
