// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'client_app_router.dart';

/// generated route for
/// [SampleHomeScreen]
class SampleHomeRoute extends PageRouteInfo<void> {
  const SampleHomeRoute({List<PageRouteInfo>? children})
    : super(SampleHomeRoute.name, initialChildren: children);

  static const String name = 'SampleHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SampleHomeScreen();
    },
  );
}

/// generated route for
/// [SamplePushScreen]
class SamplePushRoute extends PageRouteInfo<SamplePushRouteArgs> {
  SamplePushRoute({required String id, Key? key, List<PageRouteInfo>? children})
    : super(
        SamplePushRoute.name,
        args: SamplePushRouteArgs(id: id, key: key),
        rawPathParams: {'id': id},
        initialChildren: children,
      );

  static const String name = 'SamplePushRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SamplePushRouteArgs>(
        orElse: () => SamplePushRouteArgs(id: pathParams.getString('id')),
      );
      return SamplePushScreen(id: args.id, key: args.key);
    },
  );
}

class SamplePushRouteArgs {
  const SamplePushRouteArgs({required this.id, this.key});

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'SamplePushRouteArgs{id: $id, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SamplePushRouteArgs) return false;
    return id == other.id && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode;
}

/// generated route for
/// [SampleResultPickerScreen]
class SampleResultPickerRoute extends PageRouteInfo<void> {
  const SampleResultPickerRoute({List<PageRouteInfo>? children})
    : super(SampleResultPickerRoute.name, initialChildren: children);

  static const String name = 'SampleResultPickerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SampleResultPickerScreen();
    },
  );
}

/// generated route for
/// [SampleShellDetailsScreen]
class SampleShellDetailsRoute
    extends PageRouteInfo<SampleShellDetailsRouteArgs> {
  SampleShellDetailsRoute({
    required String id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         SampleShellDetailsRoute.name,
         args: SampleShellDetailsRouteArgs(id: id, key: key),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'SampleShellDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SampleShellDetailsRouteArgs>(
        orElse: () =>
            SampleShellDetailsRouteArgs(id: pathParams.getString('id')),
      );
      return SampleShellDetailsScreen(id: args.id, key: args.key);
    },
  );
}

class SampleShellDetailsRouteArgs {
  const SampleShellDetailsRouteArgs({required this.id, this.key});

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'SampleShellDetailsRouteArgs{id: $id, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SampleShellDetailsRouteArgs) return false;
    return id == other.id && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode;
}

/// generated route for
/// [SampleShellHomeScreen]
class SampleShellHomeRoute extends PageRouteInfo<void> {
  const SampleShellHomeRoute({List<PageRouteInfo>? children})
    : super(SampleShellHomeRoute.name, initialChildren: children);

  static const String name = 'SampleShellHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SampleShellHomeScreen();
    },
  );
}

/// generated route for
/// [SampleShellScreen]
class SampleShellRoute extends PageRouteInfo<void> {
  const SampleShellRoute({List<PageRouteInfo>? children})
    : super(SampleShellRoute.name, initialChildren: children);

  static const String name = 'SampleShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SampleShellScreen();
    },
  );
}

/// generated route for
/// [SampleTabOneDetailsScreen]
class SampleTabOneDetailsRoute
    extends PageRouteInfo<SampleTabOneDetailsRouteArgs> {
  SampleTabOneDetailsRoute({
    required String id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         SampleTabOneDetailsRoute.name,
         args: SampleTabOneDetailsRouteArgs(id: id, key: key),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'SampleTabOneDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SampleTabOneDetailsRouteArgs>(
        orElse: () =>
            SampleTabOneDetailsRouteArgs(id: pathParams.getString('id')),
      );
      return SampleTabOneDetailsScreen(id: args.id, key: args.key);
    },
  );
}

class SampleTabOneDetailsRouteArgs {
  const SampleTabOneDetailsRouteArgs({required this.id, this.key});

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'SampleTabOneDetailsRouteArgs{id: $id, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SampleTabOneDetailsRouteArgs) return false;
    return id == other.id && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode;
}

/// generated route for
/// [SampleTabOneHomeScreen]
class SampleTabOneHomeRoute extends PageRouteInfo<void> {
  const SampleTabOneHomeRoute({List<PageRouteInfo>? children})
    : super(SampleTabOneHomeRoute.name, initialChildren: children);

  static const String name = 'SampleTabOneHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SampleTabOneHomeScreen();
    },
  );
}

/// generated route for
/// [SampleTabOneShellScreen]
class SampleTabOneShellRoute extends PageRouteInfo<void> {
  const SampleTabOneShellRoute({List<PageRouteInfo>? children})
    : super(SampleTabOneShellRoute.name, initialChildren: children);

  static const String name = 'SampleTabOneShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SampleTabOneShellScreen();
    },
  );
}

/// generated route for
/// [SampleTabTwoScreen]
class SampleTabTwoRoute extends PageRouteInfo<void> {
  const SampleTabTwoRoute({List<PageRouteInfo>? children})
    : super(SampleTabTwoRoute.name, initialChildren: children);

  static const String name = 'SampleTabTwoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SampleTabTwoScreen();
    },
  );
}

/// generated route for
/// [SampleTabsScreen]
class SampleTabsRoute extends PageRouteInfo<void> {
  const SampleTabsRoute({List<PageRouteInfo>? children})
    : super(SampleTabsRoute.name, initialChildren: children);

  static const String name = 'SampleTabsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SampleTabsScreen();
    },
  );
}
