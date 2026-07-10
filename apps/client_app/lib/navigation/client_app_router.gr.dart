// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'client_app_router.dart';

/// generated route for
/// [AuthorizedDashboardScreen]
class AuthorizedDashboardRoute extends PageRouteInfo<void> {
  const AuthorizedDashboardRoute({List<PageRouteInfo>? children})
    : super(AuthorizedDashboardRoute.name, initialChildren: children);

  static const String name = 'AuthorizedDashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthorizedDashboardScreen();
    },
  );
}

/// generated route for
/// [AuthorizedDetailsScreen]
class AuthorizedDetailsRoute extends PageRouteInfo<AuthorizedDetailsRouteArgs> {
  AuthorizedDetailsRoute({
    required String id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         AuthorizedDetailsRoute.name,
         args: AuthorizedDetailsRouteArgs(id: id, key: key),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'AuthorizedDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<AuthorizedDetailsRouteArgs>(
        orElse: () =>
            AuthorizedDetailsRouteArgs(id: pathParams.getString('id')),
      );
      return AuthorizedDetailsScreen(id: args.id, key: args.key);
    },
  );
}

class AuthorizedDetailsRouteArgs {
  const AuthorizedDetailsRouteArgs({required this.id, this.key});

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'AuthorizedDetailsRouteArgs{id: $id, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AuthorizedDetailsRouteArgs) return false;
    return id == other.id && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode;
}

/// generated route for
/// [AuthorizedSettingsScreen]
class AuthorizedSettingsRoute extends PageRouteInfo<void> {
  const AuthorizedSettingsRoute({List<PageRouteInfo>? children})
    : super(AuthorizedSettingsRoute.name, initialChildren: children);

  static const String name = 'AuthorizedSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthorizedSettingsScreen();
    },
  );
}

/// generated route for
/// [ClientAppFlowScreen]
class ClientAppFlowRoute extends PageRouteInfo<void> {
  const ClientAppFlowRoute({List<PageRouteInfo>? children})
    : super(ClientAppFlowRoute.name, initialChildren: children);

  static const String name = 'ClientAppFlowRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ClientAppFlowScreen();
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

/// generated route for
/// [UserHomeScreen]
class UserHomeRoute extends PageRouteInfo<void> {
  const UserHomeRoute({List<PageRouteInfo>? children})
    : super(UserHomeRoute.name, initialChildren: children);

  static const String name = 'UserHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserHomeScreen();
    },
  );
}
