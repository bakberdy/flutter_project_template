// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'admin_auth_router.dart';

/// generated route for
/// [AdminAuthWrapperScreen]
class AdminAuthWrapperRoute extends PageRouteInfo<void> {
  const AdminAuthWrapperRoute({List<PageRouteInfo>? children})
    : super(AdminAuthWrapperRoute.name, initialChildren: children);

  static const String name = 'AdminAuthWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AdminAuthWrapperScreen());
    },
  );
}

/// generated route for
/// [AdminOtpScreen]
class AdminOtpRoute extends PageRouteInfo<void> {
  const AdminOtpRoute({List<PageRouteInfo>? children})
    : super(AdminOtpRoute.name, initialChildren: children);

  static const String name = 'AdminOtpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminOtpScreen();
    },
  );
}

/// generated route for
/// [AdminSignInScreen]
class AdminSignInRoute extends PageRouteInfo<void> {
  const AdminSignInRoute({List<PageRouteInfo>? children})
    : super(AdminSignInRoute.name, initialChildren: children);

  static const String name = 'AdminSignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminSignInScreen();
    },
  );
}
