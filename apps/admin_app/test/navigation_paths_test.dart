import 'package:admin_app/src/common/config/router/admin_app_navigation_paths.dart';
import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_users/admin_users.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AdminAppRouter router;

  setUp(() => router = AdminAppRouter());
  tearDown(() => router.dispose());

  final cases = <String, String>{
    AdminAppNavigationPaths.signIn: AdminSignInRoute.name,
    AdminAppNavigationPaths.home: AdminDashboardRoute.name,
    AdminAppNavigationPaths.users: UsersRoute.name,
    AdminAppNavigationPaths.user('user-1'): UserRoute.name,
    AdminAppNavigationPaths.settings: AdminSettingsRoute.name,
  };

  for (final MapEntry(key: path, value: routeName) in cases.entries) {
    test('$path resolves to $routeName', () {
      final matches = router.matcher.match(path, includePrefixMatches: true);

      expect(matches, isNotNull);
      expect(matches!.expand((match) => match.flattened).last.name, routeName);
    });
  }
}
