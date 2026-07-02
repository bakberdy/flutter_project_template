part of 'core_navigation_bloc.dart';

@freezed
sealed class CoreNavigationEvent with _$CoreNavigationEvent {
  const factory CoreNavigationEvent.push(CoreNavigationRoute route) =
      _PushRequested;

  const factory CoreNavigationEvent.replace(CoreNavigationRoute route) =
      _ReplaceRequested;

  const factory CoreNavigationEvent.replaceAll(
    List<CoreNavigationRoute> routes,
  ) = _ReplaceAllRequested;

  const factory CoreNavigationEvent.pop({Object? result}) = _PopRequested;

  const factory CoreNavigationEvent.popUntil(CoreNavigationMatch match) =
      _PopUntilRequested;

  const factory CoreNavigationEvent.deepLinkReceived(Uri uri) =
      _DeepLinkReceived;

  const factory CoreNavigationEvent.commandHandled(int commandId) =
      _CommandHandled;

  const factory CoreNavigationEvent.stackSynchronized(
    List<CoreNavigationRoute> stack,
  ) = _StackSynchronized;
}
