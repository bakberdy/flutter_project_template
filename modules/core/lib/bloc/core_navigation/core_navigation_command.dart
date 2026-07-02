part of 'core_navigation_bloc.dart';

@freezed
sealed class CoreNavigationCommand with _$CoreNavigationCommand {
  const CoreNavigationCommand._();

  const factory CoreNavigationCommand.push({
    required int id,
    required CoreNavigationRoute route,
  }) = PushNavigationCommand;

  const factory CoreNavigationCommand.replace({
    required int id,
    required CoreNavigationRoute route,
  }) = ReplaceNavigationCommand;

  const factory CoreNavigationCommand.replaceAll({
    required int id,
    required List<CoreNavigationRoute> routes,
  }) = ReplaceAllNavigationCommand;

  const factory CoreNavigationCommand.pop({required int id, Object? result}) =
      PopNavigationCommand;

  const factory CoreNavigationCommand.popUntil({
    required int id,
    required CoreNavigationMatch match,
  }) = PopUntilNavigationCommand;

  const factory CoreNavigationCommand.openDeepLink({
    required int id,
    required Uri uri,
  }) = OpenDeepLinkNavigationCommand;
}
