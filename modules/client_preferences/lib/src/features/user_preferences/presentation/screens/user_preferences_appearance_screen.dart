import 'package:auto_route/auto_route.dart';
import 'package:client_preferences/gen/l10n/client_preferences_localizations.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:client_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:client_preferences/src/features/user_preferences/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserPreferencesAppearanceScreen extends StatelessWidget
    with UiFailureHandlerMixin {
  const UserPreferencesAppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedThemeMode = context.select<ThemeBloc, UserTheme?>(
      (bloc) => bloc.state.themeMode,
    );

    return BlocListener<ThemeBloc, ThemeState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status case ErrorStateStatus(:final failure)) {
          await handleFailure(failure, context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            ClientPreferencesLocalizations.of(context).appearanceTitle,
          ),
        ),
        body: SafeArea(
          child: RadioGroup<UserTheme>(
            groupValue: selectedThemeMode,
            onChanged: (value) {
              if (value != null) {
                context.read<ThemeBloc>().setThemeMode(value);
              }
            },
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return ListView(
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignSpacing.sm,
                  ),
                  children: [
                    AppRadioListTile<UserTheme>(
                      disableBottomRadius: true,
                      title: ClientPreferencesLocalizations.of(
                        context,
                      ).themeSystem,
                      value: UserTheme.system,
                      icon: selectedThemeMode == UserTheme.system
                          ? Icon(
                              Icons.check,
                              color: context.colorScheme.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.themeMode == UserTheme.system,
                    ),
                    const Divider(
                      height: 1,
                      indent: DesignSpacing.lg,
                      endIndent: DesignSpacing.lg,
                    ),
                    AppRadioListTile<UserTheme>(
                      disableBottomRadius: true,
                      disableTopRadius: true,
                      title: ClientPreferencesLocalizations.of(
                        context,
                      ).themeLight,
                      value: UserTheme.light,
                      icon: selectedThemeMode == UserTheme.light
                          ? Icon(
                              Icons.check,
                              color: context.colorScheme.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.themeMode == UserTheme.light,
                    ),
                    const Divider(
                      height: 1,
                      indent: DesignSpacing.lg,
                      endIndent: DesignSpacing.lg,
                    ),
                    AppRadioListTile<UserTheme>(
                      disableTopRadius: true,
                      title: ClientPreferencesLocalizations.of(
                        context,
                      ).themeDark,
                      value: UserTheme.dark,
                      icon: selectedThemeMode == UserTheme.dark
                          ? Icon(
                              Icons.check,
                              color: context.colorScheme.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.themeMode == UserTheme.dark,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
