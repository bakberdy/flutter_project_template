import 'package:auto_route/auto_route.dart';
import 'package:client_preferences/src/common/client_preferences_context_x.dart';
import 'package:client_preferences/src/common/config/client_preferences_constants.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:client_preferences/src/features/user_preferences/presentation/blocs/locale/locale_bloc.dart';
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
        appBar: AppBar(title: Text(context.l10n.languageTitle)),
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
                      subtitle: context.l10n.languageKazakh,
                      value: ClientPreferencesConstants.kazakh.languageCode,
                      icon:
                          selectedLanguageCode ==
                              ClientPreferencesConstants.kazakh.languageCode
                          ? Icon(
                              Icons.check,
                              color: context.colorScheme.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.languageCode ==
                              ClientPreferencesConstants.kazakh.languageCode,
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
                      subtitle: context.l10n.languageRussian,
                      value: ClientPreferencesConstants.russian.languageCode,
                      icon:
                          selectedLanguageCode ==
                              ClientPreferencesConstants.russian.languageCode
                          ? Icon(
                              Icons.check,
                              color: context.colorScheme.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.languageCode ==
                              ClientPreferencesConstants.russian.languageCode,
                    ),
                    const Divider(
                      height: 1,
                      indent: DesignSpacing.lg,
                      endIndent: DesignSpacing.lg,
                    ),
                    AppRadioListTile<String>(
                      disableTopRadius: true,
                      title: _englishTitle,
                      subtitle: context.l10n.languageEnglish,
                      value: ClientPreferencesConstants.english.languageCode,
                      icon:
                          selectedLanguageCode ==
                              ClientPreferencesConstants.english.languageCode
                          ? Icon(
                              Icons.check,
                              color: context.colorScheme.primary,
                            )
                          : null,
                      loading:
                          state.status.isLoading &&
                          state.languageCode ==
                              ClientPreferencesConstants.english.languageCode,
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
