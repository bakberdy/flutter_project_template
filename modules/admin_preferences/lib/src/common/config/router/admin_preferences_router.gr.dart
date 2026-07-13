// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'admin_preferences_router.dart';

/// generated route for
/// [UserPreferencesAppearanceScreen]
class UserPreferencesAppearanceRoute
    extends PageRouteInfo<UserPreferencesAppearanceRouteArgs> {
  UserPreferencesAppearanceRoute({
    Key? key,
    bool showAppBar = true,
    List<PageRouteInfo>? children,
  }) : super(
         UserPreferencesAppearanceRoute.name,
         args: UserPreferencesAppearanceRouteArgs(
           key: key,
           showAppBar: showAppBar,
         ),
         initialChildren: children,
       );

  static const String name = 'UserPreferencesAppearanceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserPreferencesAppearanceRouteArgs>(
        orElse: () => const UserPreferencesAppearanceRouteArgs(),
      );
      return UserPreferencesAppearanceScreen(
        key: args.key,
        showAppBar: args.showAppBar,
      );
    },
  );
}

class UserPreferencesAppearanceRouteArgs {
  const UserPreferencesAppearanceRouteArgs({this.key, this.showAppBar = true});

  final Key? key;

  final bool showAppBar;

  @override
  String toString() {
    return 'UserPreferencesAppearanceRouteArgs{key: $key, showAppBar: $showAppBar}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserPreferencesAppearanceRouteArgs) return false;
    return key == other.key && showAppBar == other.showAppBar;
  }

  @override
  int get hashCode => key.hashCode ^ showAppBar.hashCode;
}

/// generated route for
/// [UserPreferencesLocaleScreen]
class UserPreferencesLocaleRoute
    extends PageRouteInfo<UserPreferencesLocaleRouteArgs> {
  UserPreferencesLocaleRoute({
    Key? key,
    bool showAppBar = true,
    List<PageRouteInfo>? children,
  }) : super(
         UserPreferencesLocaleRoute.name,
         args: UserPreferencesLocaleRouteArgs(key: key, showAppBar: showAppBar),
         initialChildren: children,
       );

  static const String name = 'UserPreferencesLocaleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserPreferencesLocaleRouteArgs>(
        orElse: () => const UserPreferencesLocaleRouteArgs(),
      );
      return UserPreferencesLocaleScreen(
        key: args.key,
        showAppBar: args.showAppBar,
      );
    },
  );
}

class UserPreferencesLocaleRouteArgs {
  const UserPreferencesLocaleRouteArgs({this.key, this.showAppBar = true});

  final Key? key;

  final bool showAppBar;

  @override
  String toString() {
    return 'UserPreferencesLocaleRouteArgs{key: $key, showAppBar: $showAppBar}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserPreferencesLocaleRouteArgs) return false;
    return key == other.key && showAppBar == other.showAppBar;
  }

  @override
  int get hashCode => key.hashCode ^ showAppBar.hashCode;
}

/// generated route for
/// [UserPreferencesNotificationsScreen]
class UserPreferencesNotificationsRoute
    extends PageRouteInfo<UserPreferencesNotificationsRouteArgs> {
  UserPreferencesNotificationsRoute({
    Key? key,
    bool showAppBar = true,
    List<PageRouteInfo>? children,
  }) : super(
         UserPreferencesNotificationsRoute.name,
         args: UserPreferencesNotificationsRouteArgs(
           key: key,
           showAppBar: showAppBar,
         ),
         initialChildren: children,
       );

  static const String name = 'UserPreferencesNotificationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserPreferencesNotificationsRouteArgs>(
        orElse: () => const UserPreferencesNotificationsRouteArgs(),
      );
      return WrappedRoute(
        child: UserPreferencesNotificationsScreen(
          key: args.key,
          showAppBar: args.showAppBar,
        ),
      );
    },
  );
}

class UserPreferencesNotificationsRouteArgs {
  const UserPreferencesNotificationsRouteArgs({
    this.key,
    this.showAppBar = true,
  });

  final Key? key;

  final bool showAppBar;

  @override
  String toString() {
    return 'UserPreferencesNotificationsRouteArgs{key: $key, showAppBar: $showAppBar}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserPreferencesNotificationsRouteArgs) return false;
    return key == other.key && showAppBar == other.showAppBar;
  }

  @override
  int get hashCode => key.hashCode ^ showAppBar.hashCode;
}
