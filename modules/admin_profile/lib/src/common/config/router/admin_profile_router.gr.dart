// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'admin_profile_router.dart';

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
class SessionsRoute extends PageRouteInfo<SessionsRouteArgs> {
  SessionsRoute({
    Key? key,
    bool showAppBar = true,
    List<PageRouteInfo>? children,
  }) : super(
         SessionsRoute.name,
         args: SessionsRouteArgs(key: key, showAppBar: showAppBar),
         initialChildren: children,
       );

  static const String name = 'SessionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SessionsRouteArgs>(
        orElse: () => const SessionsRouteArgs(),
      );
      return WrappedRoute(
        child: SessionsScreen(key: args.key, showAppBar: args.showAppBar),
      );
    },
  );
}

class SessionsRouteArgs {
  const SessionsRouteArgs({this.key, this.showAppBar = true});

  final Key? key;

  final bool showAppBar;

  @override
  String toString() {
    return 'SessionsRouteArgs{key: $key, showAppBar: $showAppBar}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SessionsRouteArgs) return false;
    return key == other.key && showAppBar == other.showAppBar;
  }

  @override
  int get hashCode => key.hashCode ^ showAppBar.hashCode;
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

/// generated route for
/// [UserProfileEditScreen]
class UserProfileEditRoute extends PageRouteInfo<UserProfileEditRouteArgs> {
  UserProfileEditRoute({
    Key? key,
    bool showAppBar = true,
    bool showLogoutAction = true,
    List<PageRouteInfo>? children,
  }) : super(
         UserProfileEditRoute.name,
         args: UserProfileEditRouteArgs(
           key: key,
           showAppBar: showAppBar,
           showLogoutAction: showLogoutAction,
         ),
         initialChildren: children,
       );

  static const String name = 'UserProfileEditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserProfileEditRouteArgs>(
        orElse: () => const UserProfileEditRouteArgs(),
      );
      return WrappedRoute(
        child: UserProfileEditScreen(
          key: args.key,
          showAppBar: args.showAppBar,
          showLogoutAction: args.showLogoutAction,
        ),
      );
    },
  );
}

class UserProfileEditRouteArgs {
  const UserProfileEditRouteArgs({
    this.key,
    this.showAppBar = true,
    this.showLogoutAction = true,
  });

  final Key? key;

  final bool showAppBar;

  final bool showLogoutAction;

  @override
  String toString() {
    return 'UserProfileEditRouteArgs{key: $key, showAppBar: $showAppBar, showLogoutAction: $showLogoutAction}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserProfileEditRouteArgs) return false;
    return key == other.key &&
        showAppBar == other.showAppBar &&
        showLogoutAction == other.showLogoutAction;
  }

  @override
  int get hashCode =>
      key.hashCode ^ showAppBar.hashCode ^ showLogoutAction.hashCode;
}
