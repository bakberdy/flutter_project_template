import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar.large(title: Text(context.l10n.dashboard)),
        SliverPadding(
          padding: const EdgeInsets.all(DesignSpacing.xl),
          sliver: SliverGrid.extent(
            maxCrossAxisExtent: 360,
            mainAxisSpacing: DesignSpacing.lg,
            crossAxisSpacing: DesignSpacing.lg,
            childAspectRatio: 1.8,
            children: [
              _DashboardCard(
                icon: Icons.people,
                title: context.l10n.users,
                description: context.l10n.usersCardDescription,
              ),
              _DashboardCard(
                icon: Icons.security,
                title: context.l10n.security,
                description: context.l10n.securityCardDescription,
              ),
              _DashboardCard(
                icon: Icons.monitor_heart_outlined,
                title: context.l10n.systemStatus,
                description: context.l10n.systemStatusCardDescription,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => DesignCard(
    child: Padding(
      padding: const EdgeInsets.all(DesignSpacing.lg),
      child: Row(
        children: [
          Icon(icon, size: 36, color: context.designColors.primary),
          const SizedBox(width: DesignSpacing.lg),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.designTextTheme.titleLarge),
                const SizedBox(height: DesignSpacing.xs),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.designTextTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
