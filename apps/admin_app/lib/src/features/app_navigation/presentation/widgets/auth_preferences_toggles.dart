import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_preferences/admin_preferences.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPreferencesToggles extends StatelessWidget
    with UiFailureHandlerMixin {
  const AuthPreferencesToggles({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;
    final localeState = context.watch<LocaleBloc>().state;
    final appliedTheme = themeState.appliedThemeMode ?? UserTheme.light;
    final languageCode = localeState.languageCode ?? 'en';

    return MultiBlocListener(
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
        child: Padding(
          padding: const EdgeInsets.all(DesignSpacing.xxs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: themeState.status.isLoading
                    ? null
                    : () => context.read<ThemeBloc>().setThemeMode(
                        appliedTheme == UserTheme.dark
                            ? UserTheme.light
                            : UserTheme.dark,
                      ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignSpacing.xs,
                    vertical: DesignSpacing.xs,
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
              ),
              PopupMenuButton<String>(
                initialValue: languageCode,
                enabled: !localeState.status.isLoading,
                tooltip: context.l10n.language,
                position: PopupMenuPosition.under,
                offset: const Offset(0, DesignSpacing.xs),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DesignRadii.md),
                ),
                onSelected: context.read<LocaleBloc>().setLocale,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'en',
                    child: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          const Expanded(child: Text('English')),
                          if (languageCode == 'en')
                            Icon(
                              Icons.check_rounded,
                              color: context.designColors.primary,
                            ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'ru',
                    child: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          const Expanded(child: Text('Русский')),
                          if (languageCode == 'ru')
                            Icon(
                              Icons.check_rounded,
                              color: context.designColors.primary,
                            ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'kk',
                    child: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          const Expanded(child: Text('Қазақ')),
                          if (languageCode == 'kk')
                            Icon(
                              Icons.check_rounded,
                              color: context.designColors.primary,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
                child: Opacity(
                  opacity: localeState.status.isLoading ? 0.5 : 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignSpacing.sm,
                      vertical: DesignSpacing.xs,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.language_rounded,
                          size: 20,
                          color: context.designColors.primary,
                        ),
                        const SizedBox(width: DesignSpacing.xs),
                        Text(switch (languageCode) {
                          'ru' => 'Русский',
                          'kk' => 'Қазақ',
                          _ => 'English',
                        }, style: context.designTextTheme.labelLarge),
                        const SizedBox(width: DesignSpacing.xxs),
                        const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
