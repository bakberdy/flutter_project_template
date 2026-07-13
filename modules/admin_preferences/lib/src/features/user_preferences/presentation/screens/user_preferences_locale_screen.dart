import 'package:auto_route/auto_route.dart';
import 'package:admin_preferences/src/common/admin_preferences_context_x.dart';
import 'package:admin_preferences/src/common/config/admin_preferences_constants.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:admin_preferences/src/features/user_preferences/presentation/blocs/locale/locale_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserPreferencesLocaleScreen extends StatelessWidget
    with UiFailureHandlerMixin {
  const UserPreferencesLocaleScreen({super.key, this.showAppBar = true});

  final bool showAppBar;

  static const _kazakhTitle = 'Қазақ';
  static const _russianTitle = 'Русский';
  static const _englishTitle = 'English';

  @override
  Widget build(BuildContext context) {
    final selectedLanguageCode = context.select<LocaleBloc, String?>(
      (bloc) => bloc.state.languageCode,
    );

    return BlocListener<LocaleBloc, LocaleState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status case ErrorStateStatus(:final failure)) {
          await handleFailure(failure, context);
        }
      },
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(title: Text(context.l10n.languageTitle))
            : null,
        body: SafeArea(
          child: RadioGroup<String>(
            groupValue: selectedLanguageCode,
            onChanged: (value) {
              if (value != null) {
                context.read<LocaleBloc>().setLocale(value);
              }
            },
            child: BlocBuilder<LocaleBloc, LocaleState>(
              builder: (context, state) {
                return ListView(
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignSpacing.sm,
                  ),
                  children: [
                    BaseRadioListTile<String>(
                      disableBottomRadius: true,
                      title: _kazakhTitle,
                      subtitle: context.l10n.languageKazakh,
                      value: AdminPreferencesConstants.kazakh.languageCode,
                      icon:
                          selectedLanguageCode ==
                              AdminPreferencesConstants.kazakh.languageCode
                          ? Icon(
                              Icons.check,
                              color: context.designColors.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.languageCode ==
                              AdminPreferencesConstants.kazakh.languageCode,
                    ),
                    const Divider(
                      height: 1,
                      indent: DesignSpacing.lg,
                      endIndent: DesignSpacing.lg,
                    ),
                    BaseRadioListTile<String>(
                      disableBottomRadius: true,
                      disableTopRadius: true,
                      title: _russianTitle,
                      subtitle: context.l10n.languageRussian,
                      value: AdminPreferencesConstants.russian.languageCode,
                      icon:
                          selectedLanguageCode ==
                              AdminPreferencesConstants.russian.languageCode
                          ? Icon(
                              Icons.check,
                              color: context.designColors.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.languageCode ==
                              AdminPreferencesConstants.russian.languageCode,
                    ),
                    const Divider(
                      height: 1,
                      indent: DesignSpacing.lg,
                      endIndent: DesignSpacing.lg,
                    ),
                    BaseRadioListTile<String>(
                      disableTopRadius: true,
                      title: _englishTitle,
                      subtitle: context.l10n.languageEnglish,
                      value: AdminPreferencesConstants.english.languageCode,
                      icon:
                          selectedLanguageCode ==
                              AdminPreferencesConstants.english.languageCode
                          ? Icon(
                              Icons.check,
                              color: context.designColors.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.languageCode ==
                              AdminPreferencesConstants.english.languageCode,
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
