// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'admin_users_router.dart';

/// generated route for
/// [UserScreen]
class UserRoute extends PageRouteInfo<UserRouteArgs> {
  UserRoute({required String userId, Key? key, List<PageRouteInfo>? children})
    : super(
        UserRoute.name,
        args: UserRouteArgs(userId: userId, key: key),
        rawPathParams: {'userId': userId},
        initialChildren: children,
      );

  static const String name = 'UserRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<UserRouteArgs>(
        orElse: () => UserRouteArgs(userId: pathParams.getString('userId')),
      );
      return WrappedRoute(
        child: UserScreen(userId: args.userId, key: args.key),
      );
    },
  );
}

class UserRouteArgs {
  const UserRouteArgs({required this.userId, this.key});

  final String userId;

  final Key? key;

  @override
  String toString() {
    return 'UserRouteArgs{userId: $userId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserRouteArgs) return false;
    return userId == other.userId && key == other.key;
  }

  @override
  int get hashCode => userId.hashCode ^ key.hashCode;
}

/// generated route for
/// [UsersScreen]
class UsersRoute extends PageRouteInfo<void> {
  const UsersRoute({List<PageRouteInfo>? children})
    : super(UsersRoute.name, initialChildren: children);

  static const String name = 'UsersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const UsersScreen());
    },
  );
}
