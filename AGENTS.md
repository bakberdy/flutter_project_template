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

Failure handling follows these rules:

- Represent failures with concrete `Failure` subclasses, never reason enums.
- Keep core failures under `modules/core/lib/domain/failures/`. Create every
  feature-specific failure under the owning feature's
  `lib/src/features/<feature>/domain/failures/` directory. Never place a
  feature-specific failure in `core` or `shared`; expose only the failure types
  required by that feature package's public contract.
- Use shared core failure types for reusable transport conditions such as no
  connection, timeout, invalid response, and service unavailability. Create an
  operation-specific or business-specific failure, such as
  `GetAppInfoFailure`, when a local operation fails for its own reason.
- Only `BackendFailure` may carry a user-facing `message`. Only
  `BackendFieldFailure` may carry a backend field-validation message; no other
  failure type may store localized or diagnostic text.
- Represent every distinct locally produced, user-visible error condition with
  its own concrete failure class in the module that owns the operation. Do not
  pass an error string through state or reuse one generic failure with a reason
  enum. For example, represent "Email is too short" with
  `EmailTooShortFailure`; field-specific validation failures must extend
  `FieldFailure`.
- A failure may carry the raw, non-localized values required to render its
  message. For example,
  `StartDateCannotBeBiggerThanEndDateFailure(startDate: ..., endDate: ...)`
  may carry both dates. Include those values in equality and map the failure
  type and values to a parameterized ARB message in the owning presentation
  layer. Never store the rendered, localized, or diagnostic message in a local
  failure.
- Put feature-specific failures in the owning feature's `domain/failures/`
  directory and name them by the precise condition they represent. Do not infer
  a typed failure from backend prose; use a stable backend error code when one
  is available, otherwise preserve it as a `BackendFieldFailure`.
- Resolve backend field messages through `FieldFailuresX`, using
  `backendMessageForField` or `backendMessageForAnyField`. Do not duplicate
  loops that filter `BackendFieldFailure` by `fieldName` in feature code.
- Convert exceptions to typed failures in the data or repository boundary. Do
  not pass exceptions or locally generated error strings into presentation.
- Map non-backend failure types to ARB messages in presentation code. Preserve
  a non-empty `BackendFailure.message` exactly as returned by the backend. Do
  not introduce a localization data source into repositories or use cases.
- Keep generic failure-to-UI mapping in `shared`. Resolve feature-specific
  failures inside their owning feature; `shared` must not import feature
  packages.

Treat logout as an explicit user action. Whenever the user can see and activate
a localized logout label, dispatch `CoreNavigationEvent.loggedOut()` through
`CoreNavigationBloc`. Never use the logout event for account deletion or any
other non-logout operation. After those operations change the current user's
state, dispatch `CoreNavigationEvent.refreshUser()` through
`CoreNavigationBloc` instead.

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
