import 'package:client_app/src/common/config/router/client_app_router.dart';
import 'package:client_app/src/common/presentation/navigation/client_root_route_resolver.dart';
import 'package:client_auth/client_auth.dart';
import 'package:client_profile/client_profile.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  test('keeps recoverable session failures away from auth', () {
    const failure = Failure(source: 'test');

    expect(
      clientRouteForUserState(const UserState()).routeName,
      SplashRoute.name,
    );
    expect(
      clientRouteForUserState(
        const UserState(status: StateStatus.error(failure)),
      ).routeName,
      SplashRoute.name,
    );
  });

  test('opens auth only for a confirmed empty session', () {
    expect(
      clientRouteForUserState(
        const UserState(status: StateStatus.success()),
      ).routeName,
      AuthWrapperRoute.name,
    );
  });

  test('opens the main shell for an active configured user', () {
    expect(
      clientRouteForUserState(
        UserState(user: _user, status: const StateStatus.success()),
      ).routeName,
      MainNavigationRoute.name,
    );
  });
}

final _user = User(
  id: 'user-1',
  email: 'user@example.com',
  role: UserRole.user,
  status: UserStatus.active,
  isVerified: true,
  createdAt: DateTime.utc(2026),
  isUserDataUploaded: true,
);
