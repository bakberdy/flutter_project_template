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
- `avoid_force_unwrap` prevents postfix null assertions (`value!`) so nullable
  values must be handled explicitly.

The workspace enables these rules in the root `analysis_options.yaml`.

## Stability

`project_lints` is intentionally resolved as a standalone tooling package,
separate from the application pub workspace. This lets the plugin use the
analyzer version required by `analysis_server_plugin` without conflicting with
code generators such as Freezed. Keep the analyzer packages pinned in lockstep;
the current `analysis_server_plugin` version includes fixes for Dart 3.12
analysis hangs and reduces redundant IDE re-analysis.

After changing the plugin, resolve and test it from its own directory:

```sh
cd packages/project_lints
dart pub get
dart test
```

Run `dart analyze` from the repository root to verify the plugin against the
whole workspace. Do not add `project_lints` to the root `workspace` list or add
`resolution: workspace` to its pubspec.
