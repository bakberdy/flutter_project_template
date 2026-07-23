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

## Task Scope & Context Discipline

Treat the domain, module, feature, file, behavior, or command named in the
prompt as the primary scope. Work as deeply as needed within that scope, starting
from the named source and following only the direct dependencies, contracts, and
validation paths required to complete the request.

- Keep working context task-relevant. Retain only the facts, decisions, and
  evidence needed for the current request; do not analyze unrelated modules,
  features, history, or architecture.
- Use [`docs/README.md`](docs/README.md) as the documentation index when the
  requested domain needs additional context. Read only the guide relevant to
  the prompt, then inspect the source needed to apply it; do not load every
  document preemptively.
- Expand the scope only when a required dependency, shared contract, root
  configuration, or blocking failure makes it necessary. State why the
  expansion is required.
- Do not fix, refactor, validate, or report incidental issues outside the
  requested scope unless they block completion. Preserve unrelated existing
  changes.
- Reuse source inspection, search results, decisions, and validation output
  already gathered during the task. Do not repeat reads, searches, commands, or
  completed work unless relevant state changed or the earlier result was
  incomplete.
- Validate proportionally: check changed files, affected packages, and relevant
  tests first. Run workspace-wide checks only when requested or when a shared or
  root-level change can affect the whole workspace.
- If an unrelated problem is discovered, mention it briefly only when it affects
  the requested outcome; do not turn it into a separate investigation without
  being asked.

## Build, Test, and Development Commands

- `flutter pub get`: resolve the workspace from the repository root.
- `make client-dev` / `make admin-dev`: run an app with development config.
- `dart analyze`: run workspace static analysis.
- `dart format .`: format Dart sources using the standard formatter.
- `./tool/scripts/run_all_tests.sh`: run every app and module test suite.
- `flutter test modules/core`: test one package; replace the path as needed.
- `dart run tool/validation/check_hardcoded_ui_strings.dart`: reject
  user-facing literals.
- `cd <package> && dart run build_runner build --delete-conflicting-outputs`:
  regenerate package code.
- `cd <package> && flutter gen-l10n`: regenerate package-local localization.
- when after analyzing you faced error with max width 80 and error is about text to show then try to fix it using parametrized localization

## Coding Style & Naming Conventions

Follow `flutter_lints` and standard Dart formatting.
Use `snake_case.dart` filenames, `UpperCamelCase` types, and `lowerCamelCase`
members. Do not hand-edit `*.g.dart`, `*.freezed.dart`, or other generated files.
Keep user-facing text in the owning package's ARB files and access it through
`context.l10n`; do not create handwritten localization message classes.
When building UI, access theme-dependent values through the public
`BuildContext` extensions: `context.designColors`,
`context.designSemanticColors`, `context.designTextTheme`, and
`context.designAssets`. Access immutable visual tokens through their static
token classes, such as `DesignSpacingTokens.md`, `DesignRadiusTokens.lg`,
`DesignSizeTokens.controlLg`, `DesignElevationTokens.sm`,
`DesignDurationTokens.standard`, `DesignCurveTokens.emphasized`, and
`DesignShadowTokens.md(color)`. Do not use
`Theme.of(context)`, legacy context token getters, or literal visual values when
the design system already defines that role.
Keep Blocs and Cubits focused on state coordination; never call
`Analytics.track` from them. Track business-operation success or failure in the
owning use case after the repository result, with event definitions under that
feature's `domain/analytics/` directory.

## Domain-Specific Guidelines

Read and follow the relevant document before changing code in these domains:

- When creating a business feature module, first read
  [`docs/architecture/feature-module-structure.md`](docs/architecture/feature-module-structure.md),
  then create it with
  `dart run tool/generation/create_feature_module.dart <module_name>`.
  Do not hand-scaffold a module that the generator supports.
- For workspace layout, package ownership, module placement, or structural
  changes, read
  [`docs/architecture/workspace_structure.md`](docs/architecture/workspace_structure.md).
  For business-module internals or dependencies, also read the feature-module
  guide and consult `architecture.yaml`.
- For failures, exceptions, backend errors, field validation, or
  failure-to-UI mapping, read
  [`docs/agent-guidelines/failure-handling.md`](docs/agent-guidelines/failure-handling.md).
- For logout, account deletion, or navigation caused by user/session state
  changes, read
  [`docs/agent-guidelines/session-navigation.md`](docs/agent-guidelines/session-navigation.md).

## Testing Guidelines

Use `flutter_test` and `mocktail` for test doubles; do not create handwritten
fake or mock implementations. Name files `*_test.dart` and mirror source paths
where practical. Test changed blocs, repositories, models, routes, and widgets.
Before submission, run analysis, affected tests, generators, and the string
check.

## Commit & Pull Request Guidelines

Use Conventional Commit prefixes such as `feat:`, `fix:`, `refactor:`, `test:`,
or `docs:` with a concise imperative summary. Pull requests should explain
behavior and architecture changes, list verification, link issues, and include
screenshots for UI changes. Never commit secrets; derive local configuration
from each app's `config/config.example.json`.
