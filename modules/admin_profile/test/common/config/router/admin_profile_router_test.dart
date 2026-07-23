import 'package:admin_profile/src/common/config/constants/admin_profile_navigation_paths.dart';
import 'package:admin_profile/src/common/config/router/admin_profile_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final cases = <String, String>{
    AdminProfileNavigationPaths.register: UserDataRegistrationRoute.name,
    AdminProfileNavigationPaths.blocked: UserBlockedRoute.name,
    AdminProfileNavigationPaths.deletionRequested:
        UserDeletionRequestedRoute.name,
  };

  test('declares every root route from the module path contract', () {
    expect(adminProfileRootRoutes, hasLength(cases.length));

    for (final route in adminProfileRootRoutes) {
      expect(cases[route.path], route.page.name);
    }
  });
}
