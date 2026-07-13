import 'package:flutter/widgets.dart';

class SidebarItem {
  const SidebarItem({
    required this.name,
    required this.icon,
    this.subItems,
    this.routePath,
  });

  final String name;
  final Widget icon;
  final List<SidebarItem>? subItems;
  final String? routePath;
}
