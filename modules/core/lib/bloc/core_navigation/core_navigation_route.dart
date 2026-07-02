part of 'core_navigation_bloc.dart';

@freezed
sealed class CoreNavigationRoute with _$CoreNavigationRoute {
  const factory CoreNavigationRoute({
    required String name,
    String? path,
    @Default(<String, String>{}) Map<String, String> pathParameters,
    @Default(<String, String>{}) Map<String, String> queryParameters,
    Object? extra,
  }) = _CoreNavigationRoute;
}
