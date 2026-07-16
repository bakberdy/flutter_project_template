import 'package:admin_preferences/src/common/admin_preferences_context_x.dart';
import 'package:admin_preferences/src/common/config/admin_preferences_constants.dart';
import 'package:admin_preferences/src/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:admin_preferences/src/features/user_preferences/presentation/blocs/locale/locale_bloc.dart';
import 'package:admin_preferences/src/features/user_preferences/presentation/blocs/theme/theme_bloc.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferencesDialogView extends StatefulWidget {
  const PreferencesDialogView({super.key});

  @override
  State<PreferencesDialogView> createState() => _PreferencesDialogViewState();
}

class _PreferencesDialogViewState extends State<PreferencesDialogView>
    with SingleTickerProviderStateMixin, UiFailureHandlerMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedThemeMode = context.select<ThemeBloc, UserTheme?>(
      (bloc) => bloc.state.themeMode,
    );
    final selectedLanguageCode = context.select<LocaleBloc, String?>(
      (bloc) => bloc.state.languageCode,
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<ThemeBloc, ThemeState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) async {
            if (state.status case ErrorStateStatus(:final failure)) {
              await handleFailure(failure, context);
            }
          },
        ),
        BlocListener<LocaleBloc, LocaleState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) async {
            if (state.status case ErrorStateStatus(:final failure)) {
              await handleFailure(failure, context);
            }
          },
        ),
      ],
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: context.l10n.appearanceTitle),
              Tab(text: context.l10n.languageTitle),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                RadioGroup<UserTheme>(
                  groupValue: selectedThemeMode,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<ThemeBloc>().setThemeMode(value);
                    }
                  },
                  child: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) => ListView(
                      padding: const EdgeInsets.symmetric(
                        vertical: DesignSpacingTokens.sm,
                      ),
                      children: [
                        BaseRadioListTile<UserTheme>(
                          disableBottomRadius: true,
                          title: context.l10n.themeSystem,
                          value: UserTheme.system,
                          icon: selectedThemeMode == UserTheme.system
                              ? Icon(
                                  Icons.check,
                                  color: context.designColors.primary,
                                )
                              : null,
                          loading:
                              state.status.isLoading &&
                              state.themeMode == UserTheme.system,
                        ),
                        const Divider(
                          height: 1,
                          indent: DesignSpacingTokens.lg,
                          endIndent: DesignSpacingTokens.lg,
                        ),
                        BaseRadioListTile<UserTheme>(
                          disableBottomRadius: true,
                          disableTopRadius: true,
                          title: context.l10n.themeLight,
                          value: UserTheme.light,
                          icon: selectedThemeMode == UserTheme.light
                              ? Icon(
                                  Icons.check,
                                  color: context.designColors.primary,
                                )
                              : null,
                          loading:
                              state.status.isLoading &&
                              state.themeMode == UserTheme.light,
                        ),
                        const Divider(
                          height: 1,
                          indent: DesignSpacingTokens.lg,
                          endIndent: DesignSpacingTokens.lg,
                        ),
                        BaseRadioListTile<UserTheme>(
                          disableTopRadius: true,
                          title: context.l10n.themeDark,
                          value: UserTheme.dark,
                          icon: selectedThemeMode == UserTheme.dark
                              ? Icon(
                                  Icons.check,
                                  color: context.designColors.primary,
                                )
                              : null,
                          loading:
                              state.status.isLoading &&
                              state.themeMode == UserTheme.dark,
                        ),
                      ],
                    ),
                  ),
                ),
                RadioGroup<String>(
                  groupValue: selectedLanguageCode,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<LocaleBloc>().setLocale(value);
                    }
                  },
                  child: BlocBuilder<LocaleBloc, LocaleState>(
                    builder: (context, state) => ListView(
                      padding: const EdgeInsets.symmetric(
                        vertical: DesignSpacingTokens.sm,
                      ),
                      children: [
                        _LanguageTile(
                          state: state,
                          selectedLanguageCode: selectedLanguageCode,
                          title: context.l10n.languageKazakhNative,
                          subtitle: context.l10n.languageKazakh,
                          languageCode:
                              AdminPreferencesConstants.kazakh.languageCode,
                          disableBottomRadius: true,
                        ),
                        const Divider(
                          height: 1,
                          indent: DesignSpacingTokens.lg,
                          endIndent: DesignSpacingTokens.lg,
                        ),
                        _LanguageTile(
                          state: state,
                          selectedLanguageCode: selectedLanguageCode,
                          title: context.l10n.languageRussianNative,
                          subtitle: context.l10n.languageRussian,
                          languageCode:
                              AdminPreferencesConstants.russian.languageCode,
                          disableTopRadius: true,
                          disableBottomRadius: true,
                        ),
                        const Divider(
                          height: 1,
                          indent: DesignSpacingTokens.lg,
                          endIndent: DesignSpacingTokens.lg,
                        ),
                        _LanguageTile(
                          state: state,
                          selectedLanguageCode: selectedLanguageCode,
                          title: context.l10n.languageEnglishNative,
                          subtitle: context.l10n.languageEnglish,
                          languageCode:
                              AdminPreferencesConstants.english.languageCode,
                          disableTopRadius: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.state,
    required this.selectedLanguageCode,
    required this.title,
    required this.subtitle,
    required this.languageCode,
    this.disableTopRadius = false,
    this.disableBottomRadius = false,
  });

  final LocaleState state;
  final String? selectedLanguageCode;
  final String title;
  final String subtitle;
  final String languageCode;
  final bool disableTopRadius;
  final bool disableBottomRadius;

  @override
  Widget build(BuildContext context) => BaseRadioListTile<String>(
    disableTopRadius: disableTopRadius,
    disableBottomRadius: disableBottomRadius,
    title: title,
    subtitle: subtitle,
    value: languageCode,
    icon: selectedLanguageCode == languageCode
        ? Icon(Icons.check, color: context.designColors.primary)
        : null,
    loading: state.status.isLoading && state.languageCode == languageCode,
  );
}
