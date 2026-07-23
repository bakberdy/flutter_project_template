import 'package:admin_app/src/common/config/router/admin_app_navigation_paths.dart';
import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_auth/admin_auth.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:admin_users/admin_users.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AdminAppRouter router;

  setUp(() => router = AdminAppRouter());
  tearDown(() => router.dispose());

  final cases = <String, String>{
    '/sign-in': AdminSignInRoute.name,
    '/sign-in/otp': AdminOtpRoute.name,
    AdminAppNavigationPaths.home: AdminDashboardRoute.name,
    AdminAppNavigationPaths.users: UsersRoute.name,
    AdminAppNavigationPaths.user('user-1'): UserRoute.name,
    '/register': UserDataRegistrationRoute.name,
    '/blocked': UserBlockedRoute.name,
    '/deletion-requested': UserDeletionRequestedRoute.name,
  };

  for (final MapEntry(key: path, value: routeName) in cases.entries) {
    test('$path resolves to $routeName', () {
      final matches = router.matcher.match(path, includePrefixMatches: true);

      expect(matches, isNotNull);
      expect(matches?.expand((match) => match.flattened).last.name, routeName);
    });
  }
}
