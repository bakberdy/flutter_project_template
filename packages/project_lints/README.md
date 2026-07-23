# Project lints

Analyzer lints backed by the workspace `architecture.yaml`.

- `invalid_module_dependency` reports forbidden local packages directly in
  `pubspec.yaml`.
- `cross_feature_import` prevents
  `lib/src/features/<feature>` from importing or exporting another feature in
  the same module. Shared module code belongs in `lib/src/common`.
- `common_feature_import` prevents common code from importing feature code.
  `lib/src/common/config` is the composition-root exception for DI and routes.
- `class_name_matches_file_name` requires every public class to match its
  `snake_case.dart` file name. Analytics `*_events.dart` files and libraries
  using `part` or `part of` are excluded.

The workspace enables these rules in the root `analysis_options.yaml`.
