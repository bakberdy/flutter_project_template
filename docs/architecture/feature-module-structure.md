# Feature Module Structure

## Purpose

This document defines a consistent structure and set of rules for business
modules in the Flutter workspace.

The rules apply to:

- `modules/admin_auth`
- `modules/admin_users`
- `modules/client_auth`
- `modules/client_profile`
- `modules/client_preferences`
- new business modules added under `modules/`

These rules do not require `core`, `design_system`, or applications to follow
the feature-module structure. Those packages have different responsibilities.

## Core principles

1. A module fully owns its constants, endpoints, navigation paths, assets,
   localization, DI, routes, data, domain, presentation, and tests.
2. Every module-level concern has one canonical name and location.
3. Modules do not import another module's `src/` directory.
4. An application composes multiple modules but does not contain their internal
   logic.
5. Empty architectural wrappers and capability directories are not created.
6. Generated files are never edited manually.
7. The public barrel exposes only the minimal external API.

## Canonical tree

```text
modules/<module_name>/
├── assets/
│   └── <module_name>/
│       ├── icons/
│       ├── images/
│       └── files/
├── lib/
│   ├── <module_name>.dart
│   ├── gen/
│   │   ├── assets.gen.dart
│   │   └── l10n/
│   │       ├── <module_name>_localizations.dart
│   │       ├── <module_name>_localizations_en.dart
│   │       ├── <module_name>_localizations_kk.dart
│   │       └── <module_name>_localizations_ru.dart
│   ├── l10n/
│   │   ├── <module_name>_en.arb
│   │   ├── <module_name>_kk.arb
│   │   └── <module_name>_ru.arb
│   └── src/
│       ├── common/
│       │   ├── <module_name>_context_x.dart
│       │   └── config/
│       │       ├── <module_name>_constants.dart
│       │       ├── <module_name>_api_endpoints.dart
│       │       ├── <module_name>_navigation_paths.dart
│       │       ├── di/
│       │       │   ├── <module_name>_di.dart
│       │       │   └── <module_name>_di.module.dart
│       │       ├── router/
│       │       │   ├── <module_name>_router.dart
│       │       │   └── <module_name>_router.gr.dart
│       │       └── theme/
│       │           └── <module_name>_theme_x.dart
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
├── test/
│   └── features/
├── README.md
├── build.yaml
├── l10n.yaml
└── pubspec.yaml
```

Directories such as `interceptors`, `mappers`, `services`, `router`, and other
capabilities are created only when they contain real code. Empty files and
wrappers are not created merely to align directory trees.

When a concern exists, only the name and location specified above are used.

## Module boundaries

A feature module may use another module only through its public entry point:

```dart
import 'package:client_profile/client_profile.dart';
```

The following is forbidden:

```dart
import 'package:client_profile/src/features/profile/...';
```

Within its own package, importing `package:<same_module>/src/...` is allowed.

Shared technical abstractions belong in `core`:

- API client abstractions;
- storage abstractions;
- failures;
- common state types;
- analytics primitives;
- navigation primitives;
- shared typedefs.

Shared visual elements belong in `design_system`:

- themes and design tokens;
- base widgets;
- shared icons and images;
- dialogs, buttons, and inputs.

Feature modules may use shared design-system assets through
`context.designAssets`. Such assets are not copied into a feature module or
wrapped again as module assets.

App-level composition remains in the application:

- the root navigation tree;
- composition of routes from multiple features;
- app theme composition;
- app localization delegates;
- app version and support UI;
- screens that combine multiple modules at once.

## Module context extension

Every feature module contains exactly one internal context extension:

```text
lib/src/common/<module_name>_context_x.dart
```

Example for `client_profile`:

```dart
import 'package:client_profile/gen/assets.gen.dart';
import 'package:client_profile/gen/l10n/client_profile_localizations.dart';
import 'package:flutter/widgets.dart';

extension ClientProfileContextX on BuildContext {
  ClientProfileLocalizations get l10n =>
      ClientProfileLocalizations.of(this);

  $AssetsClientProfileGen get assets => Assets.clientProfile;
}
```

The `assets` getter returns only the type and value generated by FlutterGen.
Handwritten asset classes, facades, wrappers, and string paths are forbidden,
including when the module does not yet have runtime assets.

Required names:

| Element | Format |
|---|---|
| File | `<module_name>_context_x.dart` |
| Extension | `<ModuleName>ContextX` |
| Localization getter | `l10n` |
| Asset getter | `assets` |

Presentation code uses:

```dart
context.l10n.profileTitle;
context.assets.icons.edit;
context.designAssets.icons.general.locationPoint;
```

It does not use:

```dart
ClientProfileLocalizations.of(context).profileTitle;
Assets.icons.edit;
```

The context extension and `assets.gen.dart` are not exported from the package
barrel. This prevents collisions between identical `context.l10n` and
`context.assets` extensions from different modules.

`context.assets` always means assets owned by the current feature module.
`context.designAssets` always means shared assets from `design_system`.

## Assets

Every feature module has its own `assets/` root.

```text
assets/
└── <module_name>/
    ├── icons/
    ├── images/
    └── files/
```

Rules:

- a module does not use assets from another feature module;
- app-only assets remain in the application;
- reusable visual assets are moved to `design_system`;
- assets from `design_system` are accessed through `context.designAssets`;
- design-system assets are not copied into module assets or proxied through
  `context.assets`;
- string asset paths in Dart are forbidden;
- presentation accesses module-owned assets through `context.assets`;
- `lib/gen/assets.gen.dart` is not exported;
- `context.assets` returns the generated module group from `assets.gen.dart`;
- handwritten asset classes, facades, and wrappers are forbidden;
- FlutterGen is configured in every feature module;
- an empty module stores only `.gitkeep` in the generated module group; this
  marker is not used as a runtime asset.

Configuration in `pubspec.yaml`:

```yaml
flutter:
  generate: true
  assets:
    - assets/<module_name>/

flutter_gen:
  assets:
    outputs:
      package_parameter_enabled: true
```

Configuration in `build.yaml`:

```yaml
flutter_gen_runner:
  options:
    output: lib/gen/
    line_length: 80
```

## Feature-specific theme extensions

By default, a feature module uses themes, colors, and tokens from
`design_system`. Creating a module-specific theme is not the standard styling
approach.

A feature-specific theme extension is allowed only in the rare case where a
feature has stable semantic values that do not and should not belong in the
shared design system.

Location:

```text
lib/src/common/config/theme/<module_name>_theme_x.dart
```

Example:

```dart
import 'package:flutter/material.dart';

final class ClientProfileTheme {
  const ClientProfileTheme({
    required this.verifiedColor,
    required this.pendingDeletionColor,
  });

  final Color verifiedColor;
  final Color pendingDeletionColor;
}

extension ClientProfileThemeContextX on BuildContext {
  ClientProfileTheme get clientProfileTheme {
    final colors = Theme.of(this).colorScheme;
    return ClientProfileTheme(
      verifiedColor: colors.primary,
      pendingDeletionColor: colors.error,
    );
  }
}
```

Rules:

- first check whether existing design-system tokens and theme extensions can be
  used;
- create the extension only for feature-specific semantic values;
- name the file `<module_name>_theme_x.dart`;
- give the extension and getter a module prefix, such as
  `clientProfileTheme`;
- generic getters such as `theme`, `colors`, or `appTheme` are forbidden;
- keep the extension in `common/config/theme`, not in widgets or domain;
- do not put business logic or mutable state in the extension;
- do not export the extension without a real external consumer requirement;
- when a value becomes shared by multiple modules, move it to `design_system`.

Do not create a feature theme extension merely to alias existing
`context.colorScheme`, `context.textTheme`, or design-system tokens.

## Constants

Only one module-level constants file is allowed in a module:

```text
lib/src/common/config/<module_name>_constants.dart
```

Example:

```dart
abstract final class ClientProfileConstants {
  static const phoneNumberDigitsRequired = 10;
  static const avatarMaxWidth = 1024;
  static const avatarMaxHeight = 1024;
  static const avatarImageQuality = 85;
}

abstract final class ClientProfileAnalyticsEvents {
  static const profileLoaded = 'client_profile_loaded';
  static const profileUpdated = 'client_profile_updated';
}
```

This file contains:

- validation limits;
- storage keys;
- module defaults;
- supported static values;
- analytics event names;
- shared regular expressions;
- static lookup lists;
- dial codes;
- pagination and retry limits.

Parallel files are forbidden:

```text
locale_constants.dart
local_storage_consts.dart
profile_constants.dart
validation_consts.dart
analytics_constants.dart
```

A private constant used by only one implementation class remains next to that
class:

```dart
static const _authorizationHeader = 'Authorization';
```

Endpoints and navigation paths do not belong in the constants file.

## API endpoints

Only one endpoint file is allowed in a module:

```text
lib/src/common/config/<module_name>_api_endpoints.dart
```

Example:

```dart
abstract final class ClientProfileApiEndpoints {
  static const profile = '/users/me/profile';
  static const avatar = '/users/me/avatar';
  static const accountDeletion = '/users/me/delete-request';
  static const sessions = '/auth/sessions';

  static String session(String sessionId) => '$sessions/$sessionId';
}
```

Rules:

- endpoints for all internal features live in one file;
- name the class `<ModuleName>ApiEndpoints`;
- define parameterized endpoints as methods;
- only the module's data layer imports this file;
- do not export this file;
- feature-level `configs/` directories and additional endpoint files are
  forbidden.

## Navigation paths

Only one path file is allowed in a module:

```text
lib/src/common/config/<module_name>_navigation_paths.dart
```

Example:

```dart
abstract final class ClientProfileNavigationPaths {
  static const register = 'register';
  static const blocked = 'blocked';
  static const deletionRequested = 'deletion-requested';
  static const profile = 'profile';
  static const profileEdit = 'edit';
  static const sessions = 'devices';
}
```

Rules:

- name the class `<ModuleName>NavigationPaths`;
- keep all module paths in one file;
- do not declare paths directly in the router;
- do not mix paths with general constants;
- feature-level path files are forbidden;
- keep the file internal unless an external path contract is required;
- prefer generated `PageRouteInfo` objects for navigation events.

## Dependency injection

DI always lives in:

```text
lib/src/common/config/di/
├── <module_name>_di.dart
└── <module_name>_di.module.dart
```

Example:

```dart
@InjectableInit.microPackage(
  ignoreUnregisteredTypes: [
    ApiClient,
    CoreAppConfig,
    TokenStorage,
    DeviceInfoService,
  ],
)
Future<void> configureClientProfileDependencies() async =>
    ClientProfilePackageModule().init(
      GetItHelper(GetIt.instance),
    );
```

Rules:

- use constructor injection;
- register module services with `injectable` annotations;
- list core-owned dependencies in `ignoreUnregisteredTypes`;
- the application installs the generated `<ModuleName>PackageModule`;
- the application does not manually register module repositories, use cases,
  data sources, or BLoCs;
- never edit generated `*.module.dart` files manually.

## Routing

If a module owns navigable screens, its router lives in:

```text
lib/src/common/config/router/
├── <module_name>_router.dart
└── <module_name>_router.gr.dart
```

Example:

```dart
part 'client_profile_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class ClientProfileRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => clientProfileRoutes;
}

final List<AutoRoute> clientProfileRoutes = [
  AutoRoute(
    page: UserDataRegistrationRoute.page,
    path: ClientProfileNavigationPaths.register,
  ),
];
```

Rules:

- use AutoRoute;
- annotate every navigable screen with `@RoutePage()`;
- screen filenames end with `_screen.dart`;
- screen class names end with `Screen`;
- generated route class names end with `Route`;
- the router reads paths only from the module path file;
- root route composition remains in the application;
- do not create an empty router wrapper;
- never edit generated `*.gr.dart` files manually.

## Feature layers

### Data

```text
data/
├── datasources/
├── interceptors/
├── mappers/
├── models/
├── repositories/
└── services/
```

The data layer is responsible for:

- API and local-storage calls;
- serialization;
- request and response models;
- model-to-domain mapping;
- exception handling;
- repository implementations.

Exceptions do not cross the repository implementation boundary. They are
converted into `Failure` objects.

### Domain

```text
domain/
├── analytics/
├── entities/
├── repositories/
├── services/
└── usecases/
```

The domain layer is responsible for:

- business entities;
- repository contracts;
- use cases;
- domain services;
- typed analytics events.

Domain does not import Flutter, data models, or presentation.

Analytics tracking happens inside use cases, not in BLoCs or data sources.

### Presentation

```text
presentation/
├── blocs/
├── extensions/
├── helpers/
├── screens/
└── widgets/
```

The presentation layer is responsible for:

- BLoC state management;
- screens;
- feature widgets;
- UI-only extensions;
- validation and formatting helpers.

Presentation does not import the data layer.

## Models and mappers

A serializable model lives in its own directory:

```text
data/models/session_model/
├── session_model.dart
└── session_model.g.dart
```

Rules:

- model class names have the `Model` suffix;
- a model file and its directory use the same base name;
- generate JSON code with `json_serializable`;
- do not use `_json.dart` instead of a request or response model;
- mapping does not belong in screens, BLoCs, or data sources;
- place a separate mapper in `data/mappers` when the conversion is not
  expressed by the model contract itself.

## BLoCs

Use only `presentation/blocs`, never `presentation/bloc`.

```text
presentation/blocs/<topic>/
├── <topic>_bloc.dart
├── <topic>_event.dart
├── <topic>_state.dart
└── <topic>_bloc.freezed.dart
```

Example:

```text
presentation/blocs/user_profile/
├── user_profile_bloc.dart
├── user_profile_event.dart
├── user_profile_state.dart
└── user_profile_bloc.freezed.dart
```

The directory does not repeat the `_bloc` suffix:

```text
blocs/user_profile/       # correct
blocs/user_profile_bloc/  # incorrect
```

Rules:

- use `Bloc<Event, State>`, not Cubit;
- keep bloc, event, and state in separate files;
- BLoCs use domain entities and use cases;
- do not import data models;
- model asynchronous state with `StateStatus`;
- model editable inputs with `FieldState<T>`;
- never edit generated Freezed files manually.

## Localization

Every module owns one ARB set:

```text
lib/l10n/<module_name>_en.arb
lib/l10n/<module_name>_kk.arb
lib/l10n/<module_name>_ru.arb
```

Rules:

- all locales contain the same set of keys;
- a module contains only the strings it uses;
- do not duplicate strings from sibling modules;
- app-composition strings remain in the application;
- UI accesses localization through `context.l10n`;
- the consuming application registers each module's localization delegate;
- do not export the context extension.

Canonical `l10n.yaml`:

```yaml
arb-dir: lib/l10n
template-arb-file: <module_name>_en.arb
output-dir: lib/gen/l10n
output-localization-file: <module_name>_localizations.dart
output-class: <ModuleName>Localizations
nullable-getter: false
```

## Public package API

The package has a single entry point:

```text
lib/<module_name>.dart
```

Allowed exports:

- the generated localization class when the application needs its delegate;
- the DI initializer and generated package module;
- public route classes and route lists;
- BLoCs created or observed by the application;
- entities used in public signatures;
- widgets used by app-level composition.

Forbidden exports:

- `<module_name>_context_x.dart`;
- `gen/assets.gen.dart`;
- handwritten asset classes, facades, and wrappers;
- a feature-specific theme extension without an explicit external contract;
- constants;
- API endpoints;
- navigation paths without an explicit public contract;
- data sources;
- repository implementations;
- internal services;
- internal mappers and helpers;
- internal use cases;
- generated JSON and Freezed files.

Remove a stale export immediately after moving or deleting its source file.

## Generator configuration

Every module's `build.yaml` uses the same paths and options:

```yaml
targets:
  $default:
    builders:
      json_serializable:
        options:
          field_rename: snake

      freezed:
        generate_for:
          - lib/src/features/**/domain/entities/**.dart
          - lib/src/features/**/presentation/blocs/**.dart
        options:
          to_json: false
          from_json: false
          when: false
          map: false

      injectable_generator:injectable_builder:
        options:
          auto_register: true
          generate_for_injectable: true

      flutter_gen_runner:
        options:
          output: lib/gen/
          line_length: 80

      auto_route_generator:auto_route_generator:
        generate_for:
          - lib/src/features/**/presentation/screens/**.dart

      auto_route_generator:auto_router_generator:
        generate_for:
          - lib/src/common/config/router/<module_name>_router.dart
```

Do not add AutoRoute builders to a module without routes. The FlutterGen
builder is mandatory for every feature module: the asset API is never written
manually.

## Pubspec

Rules for `pubspec.yaml`:

- a workspace package uses `resolution: workspace`;
- dependency groups use a consistent order;
- add only dependencies that are actually used;
- remove old dependencies after moving a feature;
- add a generator dependency only together with its corresponding builder;
- enable `flutter.generate` for localization;
- declare module assets with package-local paths.

## Tests

Tests mirror source features:

```text
test/features/<feature_name>/
├── data/
├── domain/
└── presentation/
```

Depending on the change, add:

- model parsing tests;
- mapper tests;
- repository tests;
- use-case tests;
- BLoC tests;
- route and path tests;
- localization and context widget smoke tests.

Remove empty and obsolete test directories after moving a feature.

## Module README

Every feature module contains a `README.md` with the following sections:

- module responsibilities;
- internal features;
- public API;
- external DI dependencies;
- routes;
- endpoints;
- assets;
- localization;
- forbidden dependencies.

## Example client auth/profile separation

`client_auth` owns only the authorization process:

```text
features/auth/
├── data/
├── domain/
└── presentation/
    ├── blocs/auth/
    └── screens/
        ├── auth_email_screen.dart
        ├── auth_otp_screen.dart
        └── auth_wrapper_screen.dart
```

`client_profile` owns the current client's data and state:

```text
features/
├── profile/
├── account_status/
└── sessions/
```

`client_profile` contains:

- current user and profile loading;
- profile registration;
- profile editing;
- avatar operations;
- account-deletion requests;
- blocked and deletion-requested presentation;
- device sessions.

`client_auth` must not retain profile or session endpoints, localization,
routes, DI registrations, assets, dependencies, or exports.

## New module checklist

Create a new module with the repository generator tool:

```bash
dart run tool/generation/create_feature_module.dart <module_name>
```

When necessary, provide the first feature-area name separately:

```bash
dart run tool/generation/create_feature_module.dart admin_reports \
  --feature reports
```

The Dart tool validates `snake_case`, does not overwrite an existing package,
adds the module to the root workspace, creates the canonical scaffold, and runs
localization, FlutterGen, DI generation, format, and analyze. Use
`--no-codegen` only when generation will intentionally run later.

- [ ] The package is added to the root workspace.
- [ ] The package is added to the consuming application's dependencies.
- [ ] A minimal public barrel is created.
- [ ] `<module_name>_context_x.dart` is created.
- [ ] `context.l10n` and `context.assets` are added.
- [ ] Shared design-system assets are accessed through
      `context.designAssets`.
- [ ] The module has its own `assets/` root.
- [ ] FlutterGen is configured; `context.assets` returns the generated module
      group.
- [ ] There are no handwritten asset classes, facades, wrappers, or string
      paths.
- [ ] The module has its own ARB set.
- [ ] `l10n.yaml` is configured.
- [ ] One constants file exists when the module has module-level constants.
- [ ] One endpoint file exists when the module has a remote API.
- [ ] One path file exists when the module has routes.
- [ ] Micro-package DI is configured.
- [ ] External core dependencies are added to `ignoreUnregisteredTypes`.
- [ ] A router exists only when the module has navigable screens.
- [ ] Features are divided into data, domain, and presentation.
- [ ] A mirrored test structure is added.
- [ ] The module README is created.
- [ ] There are no imports from another module's `src/` directory.
- [ ] Context, assets, and internal configuration are not exported.
- [ ] A feature theme extension exists only when suitable design-system tokens
      do not exist.

## Feature migration checklist

- [ ] Source code is moved to the new owner.
- [ ] Package imports use the new module name.
- [ ] Endpoints are merged into the new module's endpoint file.
- [ ] Constants are merged into the new module's constants file.
- [ ] Paths are merged into the new module's path file.
- [ ] Localization keys and assets are moved to the new owner.
- [ ] DI registrations are moved and regenerated.
- [ ] Routes are moved and regenerated.
- [ ] The consuming applications' public API usage is updated.
- [ ] Old exports are removed.
- [ ] Old dependencies are removed.
- [ ] Old localization keys and generated registrations are absent.
- [ ] Empty directories are removed.
- [ ] Tests are moved or added.

## Validating changes

Run commands from the relevant package root.

After changing the workspace or a pubspec:

```sh
flutter pub get
```

After changing an ARB file or `l10n.yaml`:

```sh
flutter gen-l10n
```

After moving files between packages or changing DI, routes, Freezed, or JSON
models:

```sh
dart run build_runner clean
dart run build_runner build
```

Formatting and analysis:

```sh
dart format lib test
flutter analyze lib
```

Tests:

```sh
flutter test
```

When changing the public API, DI, routes, localization delegates, or assets,
also validate the consuming application:

```sh
flutter analyze lib
flutter test
flutter build apk --debug
```

A feature migration is not complete while the old module still contains
imports, endpoints, constants, paths, localization keys, assets, dependencies,
generated registrations, or exports that belong to the new module.
