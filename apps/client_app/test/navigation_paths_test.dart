import 'package:client_app/src/common/config/router/client_app_navigation_paths.dart';
import 'package:client_app/src/common/config/router/client_app_router.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_preferences/client_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ClientAppRouter router;

  setUp(() => router = ClientAppRouter());
  tearDown(() => router.dispose());

  final cases = <String, String>{
    ClientAppNavigationPaths.profileEdit: UserProfileEditRoute.name,
    ClientAppNavigationPaths.profileNotifications:
        UserPreferencesNotificationsRoute.name,
    ClientAppNavigationPaths.profileAppearance:
        UserPreferencesAppearanceRoute.name,
    ClientAppNavigationPaths.profileLanguage: UserPreferencesLocaleRoute.name,
    ClientAppNavigationPaths.profileDevices: SessionsRoute.name,
  };

  for (final MapEntry(key: path, value: routeName) in cases.entries) {
    test('$path resolves to $routeName', () {
      final matches = router.matcher.match(path, includePrefixMatches: true);

      expect(matches, isNotNull);
      expect(matches!.expand((match) => match.flattened).last.name, routeName);
    });
  }
}
