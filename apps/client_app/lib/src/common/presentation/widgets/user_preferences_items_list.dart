import 'package:design_system/design_system.dart';
import 'package:client_app/src/common/client_app_localization_x.dart';
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
        BaseListTile(
          onTap: onNotificationsTap,
          title: context.l10n.profilePreferencesNotificationsAndSounds,
          leading: const Icon(Icons.notifications),
          disableBottomRadius: true,
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(
          height: 1,
          indent: DesignSpacing.lg,
          endIndent: DesignSpacing.lg,
        ),
        BaseListTile(
          disableTopRadius: true,
          disableBottomRadius: true,
          onTap: onAppearanceTap,
          title: context.l10n.profilePreferencesAppearance,
          leading: const Icon(Icons.palette),
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(
          height: 1,
          indent: DesignSpacing.lg,
          endIndent: DesignSpacing.lg,
        ),
        BaseListTile(
          disableTopRadius: true,
          onTap: onLanguageTap,
          title: context.l10n.profilePreferencesLanguage,
          leading: const Icon(Icons.language),
          trailing: const Icon(Icons.chevron_right),
        ),
      ]),
    );
  }
}
