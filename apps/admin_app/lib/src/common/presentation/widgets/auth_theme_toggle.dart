import 'package:admin_preferences/admin_preferences.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthThemeToggle extends StatelessWidget {
  const AuthThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ThemeBloc>().state;
    final appliedTheme = state.appliedThemeMode ?? UserTheme.light;

    return InkWell(
      onTap: state.status.isLoading
          ? null
          : () => context.read<ThemeBloc>().setThemeMode(
              appliedTheme == UserTheme.dark ? UserTheme.light : UserTheme.dark,
            ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.designSpacing.xs,
          vertical: context.designSpacing.xs,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) => RotationTransition(
            turns: animation,
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: Icon(
            appliedTheme == UserTheme.dark
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            key: ValueKey(appliedTheme),
          ),
        ),
      ),
    );
  }
}
