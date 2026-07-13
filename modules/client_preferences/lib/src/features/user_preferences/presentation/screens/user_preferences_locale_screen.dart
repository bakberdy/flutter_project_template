import 'package:auto_route/auto_route.dart';
import 'package:client_preferences/gen/l10n/client_preferences_localizations.dart';
import 'package:client_preferences/src/common/config/locale_constants.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:client_preferences/src/features/user_preferences/presentation/blocs/locale_bloc/locale_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UserPreferencesLocaleScreen extends StatelessWidget
    with UiFailureHandlerMixin {
  const UserPreferencesLocaleScreen({super.key});

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
        appBar: AppBar(
          title: Text(ClientPreferencesLocalizations.of(context).languageTitle),
        ),
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
                    AppRadioListTile<String>(
                      disableBottomRadius: true,
                      title: _kazakhTitle,
                      subtitle: ClientPreferencesLocalizations.of(
                        context,
                      ).languageKazakh,
                      value:
                          ClientPreferencesLocaleConstants.kazakh.languageCode,
                      icon:
                          selectedLanguageCode ==
                              ClientPreferencesLocaleConstants
                                  .kazakh
                                  .languageCode
                          ? Icon(
                              Icons.check,
                              color: context.colorScheme.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.languageCode ==
                              ClientPreferencesLocaleConstants
                                  .kazakh
                                  .languageCode,
                    ),
                    const Divider(
                      height: 1,
                      indent: DesignSpacing.lg,
                      endIndent: DesignSpacing.lg,
                    ),
                    AppRadioListTile<String>(
                      disableBottomRadius: true,
                      disableTopRadius: true,
                      title: _russianTitle,
                      subtitle: ClientPreferencesLocalizations.of(
                        context,
                      ).languageRussian,
                      value:
                          ClientPreferencesLocaleConstants.russian.languageCode,
                      icon:
                          selectedLanguageCode ==
                              ClientPreferencesLocaleConstants
                                  .russian
                                  .languageCode
                          ? Icon(
                              Icons.check,
                              color: context.colorScheme.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.languageCode ==
                              ClientPreferencesLocaleConstants
                                  .russian
                                  .languageCode,
                    ),
                    const Divider(
                      height: 1,
                      indent: DesignSpacing.lg,
                      endIndent: DesignSpacing.lg,
                    ),
                    AppRadioListTile<String>(
                      disableTopRadius: true,
                      title: _englishTitle,
                      subtitle: ClientPreferencesLocalizations.of(
                        context,
                      ).languageEnglish,
                      value:
                          ClientPreferencesLocaleConstants.english.languageCode,
                      icon:
                          selectedLanguageCode ==
                              ClientPreferencesLocaleConstants
                                  .english
                                  .languageCode
                          ? Icon(
                              Icons.check,
                              color: context.colorScheme.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.languageCode ==
                              ClientPreferencesLocaleConstants
                                  .english
                                  .languageCode,
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
