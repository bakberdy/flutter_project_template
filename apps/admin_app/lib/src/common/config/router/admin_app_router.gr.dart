// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'admin_app_router.dart';

/// generated route for
/// [AdminDashboardScreen]
class AdminDashboardRoute extends PageRouteInfo<void> {
  const AdminDashboardRoute({List<PageRouteInfo>? children})
    : super(AdminDashboardRoute.name, initialChildren: children);

  static const String name = 'AdminDashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminDashboardScreen();
    },
  );
}

/// generated route for
/// [MainNavigationScreen]
class MainNavigationRoute extends PageRouteInfo<void> {
  const MainNavigationRoute({List<PageRouteInfo>? children})
    : super(MainNavigationRoute.name, initialChildren: children);

  static const String name = 'MainNavigationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MainNavigationScreen());
    },
  );
}

/// generated route for
/// [RootNavigationScreen]
class RootNavigationRoute extends PageRouteInfo<void> {
  const RootNavigationRoute({List<PageRouteInfo>? children})
    : super(RootNavigationRoute.name, initialChildren: children);

  static const String name = 'RootNavigationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RootNavigationScreen();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}
