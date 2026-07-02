part of 'core_navigation_bloc.dart';

@freezed
sealed class CoreNavigationMatch with _$CoreNavigationMatch {
  const CoreNavigationMatch._();

  const factory CoreNavigationMatch.name(String name) = CoreNavigationNameMatch;

  const factory CoreNavigationMatch.path(String path) = CoreNavigationPathMatch;

  const factory CoreNavigationMatch.anyOf(List<CoreNavigationMatch> rules) =
      CoreNavigationAnyOfMatch;

  bool matches(CoreNavigationRoute route) => switch (this) {
    CoreNavigationNameMatch(:final name) => route.name == name,
    CoreNavigationPathMatch(:final path) => route.path == path,
    CoreNavigationAnyOfMatch(:final rules) => rules.any(
      (rule) => rule.matches(route),
    ),
  };
}
