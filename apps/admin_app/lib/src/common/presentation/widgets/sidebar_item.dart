import 'package:flutter/widgets.dart';

class SidebarItem {
  const SidebarItem({
    required this.name,
    required this.icon,
    required this.routePath,
  });

  final String name;
  final Widget icon;
  final String routePath;
}
