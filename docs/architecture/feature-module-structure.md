# Feature Module Structure

## Scope

Applies to business packages under `modules/`. Applications, `core`,
`design_system`, and `shared` have separate structures.

## Canonical structure

```text
modules/<module_name>/
├── assets/<module_name>/
├── lib/
│   ├── <module_name>.dart
│   ├── gen/{assets.gen.dart,l10n/}
│   ├── l10n/<module_name>_{en,kk,ru}.arb
│   └── src/
│       ├── common/
│       │   ├── config/
│       │   │   ├── constants/
│       │   │   │   ├── <module_name>_constants.dart
│       │   │   │   ├── <module_name>_api_endpoints.dart
│       │   │   │   └── <module_name>_navigation_paths.dart
│       │   │   ├── di/
│       │   │   │   ├── <module_name>_di.dart
│       │   │   │   └── <module_name>_di.module.dart
│       │   │   └── router/
│       │   │       ├── <module_name>_router.dart
│       │   │       └── <module_name>_router.gr.dart
│       │   ├── data/
│       │   │   ├── datasources/
│       │   │   ├── interceptors/
│       │   │   ├── mappers/
│       │   │   ├── models/
│       │   │   ├── repositories/
│       │   │   └── services/
│       │   ├── domain/
│       │   │   ├── analytics/
│       │   │   ├── entities/
│       │   │   ├── repositories/
│       │   │   ├── services/
│       │   │   └── usecases/
│       │   └── presentation/
│       │       ├── blocs/
│       │       ├── extensions/<module_name>_context_x.dart
│       │       ├── helpers/
│       │       ├── screens/
│       │       └── widgets/
│       └── features/
│           └── <feature_name>/
│               ├── data/
│               │   ├── datasources/
│               │   ├── interceptors/
│               │   ├── mappers/
│               │   ├── models/
│               │   ├── repositories/
│               │   └── services/
│               ├── domain/
│               │   ├── analytics/
│               │   ├── entities/
│               │   ├── repositories/
│               │   ├── services/
│               │   └── usecases/
│               └── presentation/
│                   ├── blocs/
│                   ├── extensions/
│                   ├── helpers/
│                   ├── screens/
│                   └── widgets/
├── test/{common,features}/
├── README.md
├── build.yaml
├── l10n.yaml
└── pubspec.yaml
```

Create only folders that contain code.

## Rules

- Modules depend only on `core`, `design_system`, and `shared`; no business
  module or internal feature depends on another.
- Apps compose public barrels; shared packages never depend on business modules.
- `common` is module-internal shared code, imports no feature, and uses the same
  layers. Code used once stays in its feature.
- Data owns I/O, models, mapping, and implementations; it converts exceptions
  to typed `Failure` objects.
- Domain owns entities, contracts, use cases, services, and analytics events;
  it imports neither Flutter, data, nor presentation.
- Presentation imports domain, never data. BLoCs never call `Analytics.track`;
  use cases track operation results.
- Keep configuration in `common/config/{constants,di,router}` with one module
  constants, endpoint, and path file. Only data imports endpoints.
- Use constructor injection, `injectable`, and `@InjectableInit.microPackage`;
  the app installs the generated module.
- Use AutoRoute and `@RoutePage()`; root route composition stays in the app.
- Name screens `*_screen.dart`/`*Screen`, routes `*Route`, and other files with
  standard Dart conventions.
- `<ModuleName>ContextX` provides internal `context.l10n` and `context.assets`;
  feature-only extensions stay in their feature.
- Use public `context.design*` extensions and static tokens, not `Theme.of`,
  when a design-system role exists.
- Models live in `data/models/<model_name>/` and use the `Model` suffix;
  mapping stays out of screens, BLoCs, and data sources.
- Use `presentation/blocs`, `Bloc<Event, State>`, `StateStatus`, and
  `FieldState<T>`; split Bloc, event, and state files.
- Access module assets through FlutterGen and user-facing ARB text through
  `context.l10n`; every locale has the same keys.
- Export only required localization, DI, routes, public contracts, and
  app-composition widgets. Keep internals private.
- Use `resolution: workspace`, declare only used dependencies, generate all
  derived code, and never edit generated files.

## Validation

```sh
flutter pub get
dart format .
dart analyze
./tool/scripts/run_all_tests.sh
dart run tool/validation/check_hardcoded_ui_strings.dart
dart run tool/validation/validate_module_dependencies.dart
git diff --check
```

Run package-local `flutter gen-l10n` and `dart run build_runner build` when
their sources change.

## Module acceptance criteria

- [ ] The module owns its features, configuration, assets, localization, and
      tests.
- [ ] It depends only on `core`, `design_system`, and `shared`.
- [ ] It has no imports or dependencies on another business module.
- [ ] `common` contains only shared internal code and imports no feature.
- [ ] Internal features do not import each other.
- [ ] Data, domain, and presentation dependencies point in the correct
      direction.
- [ ] Configuration, context extensions, DI, and routing use canonical paths.
- [ ] UI uses localization, generated assets, and design-system tokens.
- [ ] The public barrel exposes only required external contracts.
- [ ] Generated files come from source configuration and are not hand-edited.
- [ ] Tests mirror ownership and cover changed behavior.
- [ ] No stale source, dependency, export, route, DI, asset, or localization
      remains in an old owner.
- [ ] README responsibilities and the implementation agree.
- [ ] Formatting, analysis, tests, validators, generation, and diff checks
      pass.
