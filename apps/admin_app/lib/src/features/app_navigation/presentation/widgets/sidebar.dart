import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/sidebar_item.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onLogout,
    required this.items,
    super.key,
  }) : assert(items.length > 0, 'items must not be empty'),
       assert(
         selectedIndex >= 0 && selectedIndex < items.length,
         'selectedIndex must be within items bounds',
       );

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onLogout;
  final List<SidebarItem> items;

  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) {
      final compact = MediaQuery.sizeOf(context).width < 1100;
      final width = compact ? 88.0 : 264.0;
      return SizedBox(
        width: width,
        child: ColoredBox(
          color: context.designColors.surfaceContainerLow,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignSpacing.sm,
                vertical: DesignSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Brand(compact: compact),
                  const SizedBox(height: DesignSpacing.xl),
                  for (var index = 0; index < items.length; index++) ...[
                    _SidebarEntry(
                      item: items[index],
                      compact: compact,
                      selected: selectedIndex == index,
                      onTap: () => onItemSelected(index),
                    ),
                    const SizedBox(height: DesignSpacing.xs),
                  ],
                  const Spacer(),
                  _SidebarEntry(
                    item: SidebarItem(
                      icon: Icons.logout,
                      selectedIcon: Icons.logout,
                      label: context.l10n.logout,
                    ),
                    compact: compact,
                    selected: false,
                    onTap: onLogout,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _Brand extends StatelessWidget {
  const _Brand({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DesignSpacing.sm),
    child: Row(
      mainAxisAlignment: compact
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Icon(
          Icons.admin_panel_settings,
          size: 32,
          color: context.designColors.primary,
        ),
        if (!compact) ...[
          const SizedBox(width: DesignSpacing.sm),
          Expanded(
            child: Text(
              context.l10n.adminPanel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.designTextTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

class _SidebarEntry extends StatelessWidget {
  const _SidebarEntry({
    required this.item,
    required this.compact,
    required this.selected,
    required this.onTap,
  });

  final SidebarItem item;
  final bool compact;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected
        ? context.designColors.onPrimaryContainer
        : context.designColors.onSurfaceVariant;
    final entry = Material(
      color: selected
          ? context.designColors.primaryContainer
          : Colors.transparent,
      borderRadius: BorderRadius.circular(DesignRadii.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignRadii.md),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? DesignSpacing.sm : DesignSpacing.md,
            vertical: DesignSpacing.md,
          ),
          child: Row(
            mainAxisAlignment: compact
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(selected ? item.selectedIcon : item.icon, color: foreground),
              if (!compact) ...[
                const SizedBox(width: DesignSpacing.md),
                Expanded(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.designTextTheme.titleMedium?.copyWith(
                      color: foreground,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
    return compact ? Tooltip(message: item.label, child: entry) : entry;
  }
}
