// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'client_auth_router.dart';

/// generated route for
/// [AuthEmailScreen]
class AuthEmailRoute extends PageRouteInfo<void> {
  const AuthEmailRoute({List<PageRouteInfo>? children})
    : super(AuthEmailRoute.name, initialChildren: children);

  static const String name = 'AuthEmailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthEmailScreen();
    },
  );
}

/// generated route for
/// [AuthOtpScreen]
class AuthOtpRoute extends PageRouteInfo<void> {
  const AuthOtpRoute({List<PageRouteInfo>? children})
    : super(AuthOtpRoute.name, initialChildren: children);

  static const String name = 'AuthOtpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthOtpScreen();
    },
  );
}

/// generated route for
/// [AuthWrapperScreen]
class AuthWrapperRoute extends PageRouteInfo<void> {
  const AuthWrapperRoute({List<PageRouteInfo>? children})
    : super(AuthWrapperRoute.name, initialChildren: children);

  static const String name = 'AuthWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AuthWrapperScreen());
    },
  );
}
