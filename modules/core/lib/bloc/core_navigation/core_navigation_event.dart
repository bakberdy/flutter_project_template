part of 'core_navigation_bloc.dart';

@freezed
sealed class CoreNavigationEvent with _$CoreNavigationEvent {
  const factory CoreNavigationEvent.push(PageRouteInfo<dynamic> route) =
      _PushRequested;

  const factory CoreNavigationEvent.replace(PageRouteInfo<dynamic> route) =
      _ReplaceRequested;

  const factory CoreNavigationEvent.replaceAll(
    List<PageRouteInfo<dynamic>> routes,
  ) = _ReplaceAllRequested;

  const factory CoreNavigationEvent.pop({Object? result}) = _PopRequested;

  const factory CoreNavigationEvent.popUntil(PageRouteInfo<dynamic> route) =
      _PopUntilRequested;

  const factory CoreNavigationEvent.deepLinkReceived(Uri uri) =
      _DeepLinkReceived;

  const factory CoreNavigationEvent.commandHandled(int commandId) =
      _CommandHandled;

  const factory CoreNavigationEvent.stackSynchronized(
    List<PageRouteInfo<dynamic>> stack,
  ) = _StackSynchronized;
}
