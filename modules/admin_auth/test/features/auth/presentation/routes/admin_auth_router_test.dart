import 'package:admin_auth/src/common/config/admin_auth_navigation_paths.dart';
import 'package:admin_auth/src/common/config/router/admin_auth_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('declares sign-in as the module root route', () {
    final route = adminAuthRoutes.single;

    expect(route.path, AdminAuthNavigationPaths.signIn);
    expect(route.page.name, AdminAuthWrapperRoute.name);
  });

  test('declares email and OTP child routes from module paths', () {
    final children = adminAuthRoutes.single.children!;

    expect(children, hasLength(2));
    expect(children.first.path, AdminAuthNavigationPaths.email);
    expect(children.first.page.name, AdminSignInRoute.name);
    expect(children.last.path, AdminAuthNavigationPaths.otp);
    expect(children.last.page.name, AdminOtpRoute.name);
  });
}
