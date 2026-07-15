import 'package:admin_app/src/common/admin_app_localization_x.dart';
import 'package:admin_preferences/admin_preferences.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLocaleMenu extends StatelessWidget {
  const AuthLocaleMenu({super.key});

  static const _languages = <String, String>{
    'en': 'English',
    'ru': 'Русский',
    'kk': 'Қазақ',
  };

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LocaleBloc>().state;
    final languageCode = state.languageCode ?? 'en';

    return PopupMenuButton<String>(
      initialValue: languageCode,
      enabled: !state.status.isLoading,
      tooltip: context.l10n.language,
      position: PopupMenuPosition.under,
      offset: const Offset(0, DesignSpacing.xs),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignRadii.md),
      ),
      onSelected: context.read<LocaleBloc>().setLocale,
      itemBuilder: (context) => _languages.entries
          .map(
            (language) => PopupMenuItem(
              value: language.key,
              child: SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Expanded(child: Text(language.value)),
                    if (languageCode == language.key)
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
              Text(
                _languages[languageCode] ?? _languages['en']!,
                style: context.designTextTheme.labelLarge,
              ),
              const SizedBox(width: DesignSpacing.xxs),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
