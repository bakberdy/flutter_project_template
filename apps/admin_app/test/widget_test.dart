import 'package:admin_app/src/common/config/router/admin_app_router.dart';
import 'package:admin_app/src/common/presentation/navigation/admin_root_route_resolver.dart';
import 'package:admin_auth/admin_auth.dart';
import 'package:admin_profile/admin_profile.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  test('keeps recoverable session failures away from auth', () {
    const failure = UnknownFailure(source: 'test');

    expect(
      adminRouteForUserState(const UserState()).routeName,
      SplashRoute.name,
    );
    expect(
      adminRouteForUserState(
        const UserState(status: StateStatus.error(failure)),
      ).routeName,
      SplashRoute.name,
    );
  });

  test('opens auth only for a confirmed empty session', () {
    expect(
      adminRouteForUserState(
        const UserState(status: StateStatus.success()),
      ).routeName,
      AdminAuthWrapperRoute.name,
    );
  });

  test('opens the main shell for an active configured admin', () {
    expect(
      adminRouteForUserState(
        UserState(user: _admin, status: const StateStatus.success()),
      ).routeName,
      MainNavigationRoute.name,
    );
  });
}

final _admin = User(
  id: 'admin-1',
  email: 'admin@example.com',
  role: UserRole.admin,
  status: UserStatus.active,
  isVerified: true,
  createdAt: DateTime.utc(2026),
  isUserDataUploaded: true,
);
