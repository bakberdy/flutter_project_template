import 'package:flutter/material.dart';

typedef AppThemeScopeBuilder =
    Widget Function(BuildContext context, ThemeMode themeMode, Widget? child);

class AppThemeScope extends StatelessWidget {
  const AppThemeScope({required this.builder, this.child, super.key});

  final AppThemeScopeBuilder builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) =>
      builder(context, ThemeMode.system, child);
}
