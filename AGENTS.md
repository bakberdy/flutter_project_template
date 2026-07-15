# Repository Guidelines

## Project Structure & Module Organization

This is a Dart workspace. Executable targets live in
`apps/client_app` and `apps/admin_app`; reusable packages live under `modules/`.

- `core`: infrastructure and foundational technical abstractions only.
- `design_system`: themes, tokens, assets, and reusable visual components only.
- `shared`: reusable presentation and integration code combining core and UI.
- `admin_*` / `client_*`: self-contained business feature packages.
- `apps/*`: bootstrap, root DI/navigation, providers, localization, and theme.

Dependency direction is `app -> features -> shared -> core/design_system`;
features may also use `core` and `design_system`. Keep `core` and
`design_system` independent, and never make foundational packages depend on an
app or feature. Do not add feature-to-feature dependencies without an existing
approved public contract; import another package only through its public barrel,
never its `src/` tree.

Feature packages own their routes, DI, assets, localization, data, domain,
presentation, and tests. Preserve the existing
`lib/src/features/<feature>/{data,domain,presentation}` structure. Add capability
folders only when they contain real code. Keep one responsibility per file,
avoid empty wrappers, and expose a minimal public API. Assets, ARB files, and
tests stay with their owning package.

## Build, Test, and Development Commands

- `flutter pub get`: resolve the workspace from the repository root.
- `make client-dev` / `make admin-dev`: run an app with development config.
- `dart analyze`: run workspace static analysis.
- `dart format .`: format Dart sources using the standard formatter.
- `flutter test modules/core`: test one package; replace the path as needed.
- `dart run tool/check_hardcoded_ui_strings.dart`: reject user-facing literals.
- `cd <package> && dart run build_runner build --delete-conflicting-outputs`:
  regenerate package code.
- `cd <package> && flutter gen-l10n`: regenerate package-local localization.

## Coding Style & Naming Conventions

Follow `flutter_lints` and standard Dart formatting.
Use `snake_case.dart` filenames, `UpperCamelCase` types, and `lowerCamelCase`
members. Do not hand-edit `*.g.dart`, `*.freezed.dart`, or other generated files.
Keep user-facing text in the owning package's ARB files and access it through
`context.l10n`; do not create handwritten localization message classes.
Keep Blocs and Cubits focused on state coordination; never call
`Analytics.track` from them. Track business-operation success or failure in the
owning use case after the repository result, with event definitions under that
feature's `domain/analytics/` directory.

## Testing Guidelines

Use `flutter_test`; name files `*_test.dart` and mirror source paths where
practical. Test changed blocs, repositories, models, routes, and widgets. Before
submission, run analysis, affected tests, generators, and the string check.

## Commit & Pull Request Guidelines

Use Conventional Commit prefixes such as `feat:`, `fix:`, `refactor:`, `test:`,
or `docs:` with a concise imperative summary. Pull requests should explain
behavior and architecture changes, list verification, link issues, and include
screenshots for UI changes. Never commit secrets; derive local configuration
from each app's `config/config.example.json`.
