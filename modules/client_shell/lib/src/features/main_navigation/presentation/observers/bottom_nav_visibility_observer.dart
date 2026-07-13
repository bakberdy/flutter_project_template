import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

class BottomNavVisibilityObserver extends AutoRouterObserver {
  BottomNavVisibilityObserver({required this.onVisibilityChanged});

  final ValueChanged<bool> onVisibilityChanged;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _sync(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _sync(previousRoute);
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _sync(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void _sync(Route<dynamic>? route) {
    onVisibilityChanged(route?.data?.meta['showBottomNav'] == true);
  }
}
