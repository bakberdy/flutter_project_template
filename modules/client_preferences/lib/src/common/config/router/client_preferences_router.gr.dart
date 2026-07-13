// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'client_preferences_router.dart';

/// generated route for
/// [UserPreferencesAppearanceScreen]
class UserPreferencesAppearanceRoute extends PageRouteInfo<void> {
  const UserPreferencesAppearanceRoute({List<PageRouteInfo>? children})
    : super(UserPreferencesAppearanceRoute.name, initialChildren: children);

  static const String name = 'UserPreferencesAppearanceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserPreferencesAppearanceScreen();
    },
  );
}

/// generated route for
/// [UserPreferencesLocaleScreen]
class UserPreferencesLocaleRoute extends PageRouteInfo<void> {
  const UserPreferencesLocaleRoute({List<PageRouteInfo>? children})
    : super(UserPreferencesLocaleRoute.name, initialChildren: children);

  static const String name = 'UserPreferencesLocaleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserPreferencesLocaleScreen();
    },
  );
}

/// generated route for
/// [UserPreferencesNotificationsScreen]
class UserPreferencesNotificationsRoute extends PageRouteInfo<void> {
  const UserPreferencesNotificationsRoute({List<PageRouteInfo>? children})
    : super(UserPreferencesNotificationsRoute.name, initialChildren: children);

  static const String name = 'UserPreferencesNotificationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const UserPreferencesNotificationsScreen());
    },
  );
}
