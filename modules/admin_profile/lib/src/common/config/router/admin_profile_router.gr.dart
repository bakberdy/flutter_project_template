// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'admin_profile_router.dart';

/// generated route for
/// [UserBlockedScreen]
class UserBlockedRoute extends PageRouteInfo<void> {
  const UserBlockedRoute({List<PageRouteInfo>? children})
    : super(UserBlockedRoute.name, initialChildren: children);

  static const String name = 'UserBlockedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserBlockedScreen();
    },
  );
}

/// generated route for
/// [UserDataRegistrationScreen]
class UserDataRegistrationRoute extends PageRouteInfo<void> {
  const UserDataRegistrationRoute({List<PageRouteInfo>? children})
    : super(UserDataRegistrationRoute.name, initialChildren: children);

  static const String name = 'UserDataRegistrationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const UserDataRegistrationScreen());
    },
  );
}

/// generated route for
/// [UserDeletionRequestedScreen]
class UserDeletionRequestedRoute extends PageRouteInfo<void> {
  const UserDeletionRequestedRoute({List<PageRouteInfo>? children})
    : super(UserDeletionRequestedRoute.name, initialChildren: children);

  static const String name = 'UserDeletionRequestedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserDeletionRequestedScreen();
    },
  );
}
