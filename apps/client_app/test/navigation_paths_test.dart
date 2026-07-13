import 'package:client_app/navigation/client_app_router.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_preferences/client_preferences.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ClientAppRouter router;

  setUp(() => router = ClientAppRouter());
  tearDown(() => router.dispose());

  final cases = <String, String>{
    AppNavigationPaths.profileEdit: UserProfileEditRoute.name,
    AppNavigationPaths.profileNotifications:
        UserPreferencesNotificationsRoute.name,
    AppNavigationPaths.profileAppearance: UserPreferencesAppearanceRoute.name,
    AppNavigationPaths.profileLanguage: UserPreferencesLocaleRoute.name,
    AppNavigationPaths.profileDevices: SessionsRoute.name,
  };

  for (final MapEntry(key: path, value: routeName) in cases.entries) {
    test('$path resolves to $routeName', () {
      final matches = router.matcher.match(path, includePrefixMatches: true);

      expect(matches, isNotNull);
      expect(matches!.expand((match) => match.flattened).last.name, routeName);
    });
  }
}
