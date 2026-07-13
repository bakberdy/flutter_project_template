import 'package:flutter/material.dart';

class SidebarItem {
  const SidebarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
