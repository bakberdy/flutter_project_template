// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'client_profile_router.dart';

/// generated route for
/// [ProfileTabShellScreen]
class ProfileTabShellRoute extends PageRouteInfo<void> {
  const ProfileTabShellRoute({List<PageRouteInfo>? children})
    : super(ProfileTabShellRoute.name, initialChildren: children);

  static const String name = 'ProfileTabShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ProfileTabShellScreen());
    },
  );
}

/// generated route for
/// [SessionsScreen]
class SessionsRoute extends PageRouteInfo<void> {
  const SessionsRoute({List<PageRouteInfo>? children})
    : super(SessionsRoute.name, initialChildren: children);

  static const String name = 'SessionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SessionsScreen());
    },
  );
}

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
class UserDeletionRequestedRoute
    extends PageRouteInfo<UserDeletionRequestedRouteArgs> {
  UserDeletionRequestedRoute({
    bool isDeleted = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         UserDeletionRequestedRoute.name,
         args: UserDeletionRequestedRouteArgs(isDeleted: isDeleted, key: key),
         initialChildren: children,
       );

  static const String name = 'UserDeletionRequestedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserDeletionRequestedRouteArgs>(
        orElse: () => const UserDeletionRequestedRouteArgs(),
      );
      return UserDeletionRequestedScreen(
        isDeleted: args.isDeleted,
        key: args.key,
      );
    },
  );
}

class UserDeletionRequestedRouteArgs {
  const UserDeletionRequestedRouteArgs({this.isDeleted = false, this.key});

  final bool isDeleted;

  final Key? key;

  @override
  String toString() {
    return 'UserDeletionRequestedRouteArgs{isDeleted: $isDeleted, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserDeletionRequestedRouteArgs) return false;
    return isDeleted == other.isDeleted && key == other.key;
  }

  @override
  int get hashCode => isDeleted.hashCode ^ key.hashCode;
}

/// generated route for
/// [UserProfileEditScreen]
class UserProfileEditRoute extends PageRouteInfo<void> {
  const UserProfileEditRoute({List<PageRouteInfo>? children})
    : super(UserProfileEditRoute.name, initialChildren: children);

  static const String name = 'UserProfileEditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const UserProfileEditScreen());
    },
  );
}
