part of 'core_navigation_bloc.dart';

@freezed
sealed class CoreNavigationCommand with _$CoreNavigationCommand {
  const CoreNavigationCommand._();

  const factory CoreNavigationCommand.push({
    required int id,
    required PageRouteInfo<dynamic> route,
  }) = PushNavigationCommand;

  const factory CoreNavigationCommand.navigatePath({
    required int id,
    required String path,
    required bool includePrefixMatches,
  }) = NavigatePathNavigationCommand;

  const factory CoreNavigationCommand.replace({
    required int id,
    required PageRouteInfo<dynamic> route,
  }) = ReplaceNavigationCommand;

  const factory CoreNavigationCommand.replaceAll({
    required int id,
    required List<PageRouteInfo<dynamic>> routes,
  }) = ReplaceAllNavigationCommand;

  const factory CoreNavigationCommand.pop({required int id, Object? result}) =
      PopNavigationCommand;

  const factory CoreNavigationCommand.popUntil({
    required int id,
    required PageRouteInfo<dynamic> route,
  }) = PopUntilNavigationCommand;

  const factory CoreNavigationCommand.openDeepLink({
    required int id,
    required Uri uri,
  }) = OpenDeepLinkNavigationCommand;

  const factory CoreNavigationCommand.unAuthenticated({required int id}) =
      UnAuthenticatedNavigationCommand;

  const factory CoreNavigationCommand.authenticated({required int id}) =
      AuthenticatedNavigationCommand;

  const factory CoreNavigationCommand.refreshUser({required int id}) =
      RefreshUserNavigationCommand;
}
