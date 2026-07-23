import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_preferences/admin_preferences.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLocaleMenu extends StatelessWidget {
  const AuthLocaleMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LocaleBloc>().state;
    final languageCode = state.languageCode ?? 'en';
    final languages = [
      (code: 'en', name: context.l10n.languageEnglishNative),
      (code: 'ru', name: context.l10n.languageRussianNative),
      (code: 'kk', name: context.l10n.languageKazakhNative),
    ];

    return PopupMenuButton<String>(
      initialValue: languageCode,
      enabled: !state.status.isLoading,
      tooltip: 'Language',
      position: PopupMenuPosition.under,
      offset: const Offset(0, DesignSpacingTokens.xs),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignRadiusTokens.md),
      ),
      onSelected: context.read<LocaleBloc>().setLocale,
      itemBuilder: (context) => languages
          .map(
            (language) => PopupMenuItem(
              value: language.code,
              child: SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Expanded(child: Text(language.name)),
                    if (languageCode == language.code)
                      Icon(
                        Icons.check_rounded,
                        color: context.designColors.primary,
                      ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
      child: Opacity(
        opacity: state.status.isLoading ? 0.5 : 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignSpacingTokens.sm,
            vertical: DesignSpacingTokens.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language_rounded,
                size: 20,
                color: context.designColors.primary,
              ),
              const SizedBox(width: DesignSpacingTokens.xs),
              Text(
                languages
                    .firstWhere(
                      (language) => language.code == languageCode,
                      orElse: () => languages.first,
                    )
                    .name,
                style: context.designTextTheme.labelLarge,
              ),
              const SizedBox(width: DesignSpacingTokens.xxs),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
