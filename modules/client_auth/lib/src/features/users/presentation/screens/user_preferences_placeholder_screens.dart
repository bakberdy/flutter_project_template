import 'package:auto_route/auto_route.dart';
import 'package:client_auth/gen/l10n/client_auth_localizations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserPreferencesNotificationsScreen extends StatelessWidget {
  const UserPreferencesNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        ClientAuthLocalizations.of(
          context,
        ).profilePreferencesNotificationsAndSounds,
      ),
    ),
    body: const SizedBox.shrink(),
  );
}

@RoutePage()
class UserPreferencesAppearanceScreen extends StatelessWidget {
  const UserPreferencesAppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        ClientAuthLocalizations.of(context).profilePreferencesAppearance,
      ),
    ),
    body: const SizedBox.shrink(),
  );
}

@RoutePage()
class UserPreferencesLocaleScreen extends StatelessWidget {
  const UserPreferencesLocaleScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        ClientAuthLocalizations.of(context).profilePreferencesLanguage,
      ),
    ),
    body: const SizedBox.shrink(),
  );
}
