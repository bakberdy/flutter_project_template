import 'package:auto_route/auto_route.dart';
import 'package:client_auth/src/common/client_auth_context_x.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserPreferencesNotificationsScreen extends StatelessWidget {
  const UserPreferencesNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(context.l10n.profilePreferencesNotificationsAndSounds),
    ),
    body: const SizedBox.shrink(),
  );
}

@RoutePage()
class UserPreferencesAppearanceScreen extends StatelessWidget {
  const UserPreferencesAppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.profilePreferencesAppearance)),
    body: const SizedBox.shrink(),
  );
}

@RoutePage()
class UserPreferencesLocaleScreen extends StatelessWidget {
  const UserPreferencesLocaleScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.profilePreferencesLanguage)),
    body: const SizedBox.shrink(),
  );
}
