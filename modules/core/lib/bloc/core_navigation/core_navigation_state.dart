part of 'core_navigation_bloc.dart';

@freezed
sealed class CoreNavigationState with _$CoreNavigationState {
  const factory CoreNavigationState({
    @Default(<CoreNavigationRoute>[]) List<CoreNavigationRoute> stack,
    @Default(<CoreNavigationCommand>[])
    List<CoreNavigationCommand> pendingCommands,
    Uri? lastDeepLink,
  }) = _CoreNavigationState;
}

extension CoreNavigationStateX on CoreNavigationState {
  bool get canPop => stack.isNotEmpty;

  CoreNavigationRoute? get currentRoute => stack.isEmpty ? null : stack.last;

  CoreNavigationCommand? get nextCommand =>
      pendingCommands.isEmpty ? null : pendingCommands.first;
}
