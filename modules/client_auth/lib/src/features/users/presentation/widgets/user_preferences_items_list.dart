import 'package:design_system/design_system.dart';
import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:flutter/material.dart';

class UserPreferencesItemsList extends StatelessWidget {
  const UserPreferencesItemsList({
    super.key,
    required this.onNotificationsTap,
    required this.onAppearanceTap,
    required this.onLanguageTap,
  });
  final VoidCallback onNotificationsTap;
  final VoidCallback onAppearanceTap;
  final VoidCallback onLanguageTap;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        AppItemCard(
          onTap: onNotificationsTap,
          title: ClientAuthLocalizations.of(
            context,
          ).profilePreferencesNotificationsAndSounds,
          leading: const Icon(Icons.notifications),
          disableBottomRadius: true,
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(
          height: 1,
          indent: DesignSpacing.lg,
          endIndent: DesignSpacing.lg,
        ),
        AppItemCard(
          disableTopRadius: true,
          disableBottomRadius: true,
          onTap: onAppearanceTap,
          title: ClientAuthLocalizations.of(
            context,
          ).profilePreferencesAppearance,
          leading: const Icon(Icons.palette),
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(
          height: 1,
          indent: DesignSpacing.lg,
          endIndent: DesignSpacing.lg,
        ),
        AppItemCard(
          disableTopRadius: true,
          onTap: onLanguageTap,
          title: ClientAuthLocalizations.of(context).profilePreferencesLanguage,
          leading: const Icon(Icons.language),
          trailing: const Icon(Icons.chevron_right),
        ),
      ]),
    );
  }
}
