import 'package:admin_app/src/common/presentation/widgets/sidebar_item.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SidebarNavigationList extends StatelessWidget {
  const SidebarNavigationList({
    required this.pages,
    required this.onPageChanged,
    super.key,
    this.selectedRoutePath,
  });

  final List<SidebarItem> pages;
  final ValueChanged<String> onPageChanged;
  final String? selectedRoutePath;

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: pages.length,
    itemBuilder: (context, index) {
      final page = pages[index];
      final isSelected = selectedRoutePath == page.routePath;
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
        onTap: () => onPageChanged(page.routePath),
      );
    },
  );
}
