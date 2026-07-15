import 'package:admin_app/src/features/app_navigation/presentation/widgets/auth_locale_menu.dart';
import 'package:admin_app/src/features/app_navigation/presentation/widgets/auth_theme_toggle.dart';
import 'package:admin_preferences/admin_preferences.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class AuthPreferencesToggles extends StatelessWidget
    with UiFailureHandlerMixin {
  const AuthPreferencesToggles({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocListener(
    listeners: [
      BlocListener<ThemeBloc, ThemeState>(
        listenWhen: (previous, current) =>
            previous.status != current.status && current.status.isError,
        listener: (context, state) async {
          if (state.status case ErrorStateStatus(:final failure)) {
            await handleFailure(failure, context);
          }
        },
      ),
      BlocListener<LocaleBloc, LocaleState>(
        listenWhen: (previous, current) =>
            previous.status != current.status && current.status.isError,
        listener: (context, state) async {
          if (state.status case ErrorStateStatus(:final failure)) {
            await handleFailure(failure, context);
          }
        },
      ),
    ],
    child: Material(
      color: context.designColors.surfaceContainerLow,
      elevation: 4,
      shadowColor: context.designColors.shadow.withValues(alpha: 0.08),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.designColors.outlineVariant),
        borderRadius: BorderRadius.circular(DesignRadii.lg),
      ),
      child: const Padding(
        padding: EdgeInsets.all(DesignSpacing.xxs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [AuthThemeToggle(), AuthLocaleMenu()],
        ),
      ),
    ),
  );
}
