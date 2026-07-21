# Структура feature-модулей

## Назначение

Этот документ определяет единую структуру и правила для бизнес-модулей Flutter
workspace.

Правила распространяются на:

- `modules/admin_auth`
- `modules/admin_users`
- `modules/client_auth`
- `modules/client_profile`
- `modules/client_preferences`
- новые бизнес-модули, которые будут добавлены в `modules/`

Правила не требуют от `core`, `design_system` и приложений повторять структуру
feature-модулей. У этих пакетов другая ответственность.

## Основные принципы

1. Модуль полностью владеет своими constants, endpoints, navigation paths,
   assets, localization, DI, routes, data, domain, presentation и tests.
2. У каждой module-level concern есть одно каноническое имя и расположение.
3. Модули не импортируют `src/` других модулей.
4. Приложение собирает несколько модулей, но не хранит их внутреннюю логику.
5. Пустые архитектурные wrappers и capability-папки не создаются.
6. Generated-файлы не редактируются вручную.
7. Public barrel содержит только минимальный внешний API.

## Каноническое дерево

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

Папки `interceptors`, `mappers`, `services`, `router` и другие capabilities
создаются только при наличии реального кода. Пустые файлы и wrappers для
выравнивания дерева не создаются.

При наличии concern используется только указанное выше имя и расположение.

## Границы модулей

Feature-модуль может использовать другой модуль только через его публичный
entry point:

```dart
import 'package:client_profile/client_profile.dart';
```

Запрещено:

```dart
import 'package:client_profile/src/features/profile/...';
```

Внутри собственного пакета импорт `package:<same_module>/src/...` разрешён.

Общие технические abstractions находятся в `core`:

- API client abstractions;
- storage abstractions;
- failures;
- common state types;
- analytics primitives;
- navigation primitives;
- shared typedefs.

Общие визуальные элементы находятся в `design_system`:

- theme и design tokens;
- базовые widgets;
- общие icons/images;
- dialogs, buttons и inputs.

Feature-модули могут использовать общие assets дизайн-системы через
`context.designAssets`. Такие assets не копируются в feature-модуль и не
оборачиваются повторно в module assets.

App-level composition остаётся в приложении:

- root navigation tree;
- сборка нескольких feature routes;
- app theme composition;
- app localization delegates;
- app version и support UI;
- экраны, одновременно объединяющие несколько модулей.

## Module context extension

Каждый feature-модуль содержит ровно один внутренний context extension:

```text
lib/src/common/<module_name>_context_x.dart
```

Пример для `client_profile`:

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

`assets` возвращает только тип и значение, сгенерированные FlutterGen.
Рукописные asset classes, facades, wrappers и строковые пути запрещены, в том
числе когда у модуля пока нет runtime assets.

Обязательные имена:

| Элемент | Формат |
|---|---|
| Файл | `<module_name>_context_x.dart` |
| Extension | `<ModuleName>ContextX` |
| Localization getter | `l10n` |
| Asset getter | `assets` |

Внутри presentation используется:

```dart
context.l10n.profileTitle;
context.assets.icons.edit;
context.designAssets.icons.general.locationPoint;
```

Не используется:

```dart
ClientProfileLocalizations.of(context).profileTitle;
Assets.icons.edit;
```

Context extension и `assets.gen.dart` не экспортируются из package barrel. Это
предотвращает конфликт одинаковых `context.l10n` и `context.assets` между
модулями.

`context.assets` всегда означает assets текущего feature-модуля.
`context.designAssets` всегда означает общие assets из `design_system`.

## Assets

Каждый feature-модуль имеет собственный `assets/` root.

```text
assets/
└── <module_name>/
    ├── icons/
    ├── images/
    └── files/
```

Правила:

- модуль не использует assets другого feature-модуля;
- app-only assets остаются в приложении;
- reusable visual assets переносятся в `design_system`;
- assets из `design_system` используются через `context.designAssets`;
- design-system assets не копируются в module assets и не проксируются через
  `context.assets`;
- строковые пути до assets в Dart запрещены;
- presentation получает module-owned assets через `context.assets`;
- `lib/gen/assets.gen.dart` не экспортируется;
- `context.assets` возвращает generated module group из `assets.gen.dart`;
- рукописные asset classes, facades и wrappers запрещены;
- FlutterGen настраивается во всех feature-модулях;
- пустой модуль хранит только `.gitkeep` в generated module group; этот marker
  не используется как runtime asset.

Настройка в `pubspec.yaml`:

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

Настройка в `build.yaml`:

```yaml
flutter_gen_runner:
  options:
    output: lib/gen/
    line_length: 80
```

## Feature-specific theme extensions

По умолчанию feature-модуль использует theme, colors и tokens из
`design_system`. Создание собственной темы модуля не является обычным способом
стилизации.

Feature-specific theme extension допускается только в редком случае, когда у
feature есть устойчивые семантические значения, которых нет и не должно быть в
общей дизайн-системе.

Расположение:

```text
lib/src/common/config/theme/<module_name>_theme_x.dart
```

Пример:

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

Правила:

- сначала проверяется возможность использовать существующие design-system
  tokens и theme extensions;
- расширение создаётся только для feature-specific semantic values;
- файл называется `<module_name>_theme_x.dart`;
- extension и getter имеют module prefix, например `clientProfileTheme`;
- generic getters вроде `theme`, `colors` или `appTheme` запрещены;
- extension находится в `common/config/theme`, а не в widgets или domain;
- extension не содержит business logic и mutable state;
- extension не экспортируется без реальной необходимости внешнего потребителя;
- если значение становится общим для нескольких модулей, оно переносится в
  `design_system`.

Не следует создавать feature theme extension только для aliases уже
существующих `context.colorScheme`, `context.textTheme` или design-system
tokens.

## Constants

Во всём модуле допускается один module-level constants-файл:

```text
lib/src/common/config/<module_name>_constants.dart
```

Пример:

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

В этот файл входят:

- validation limits;
- storage keys;
- module defaults;
- supported static values;
- analytics event names;
- shared regular expressions;
- static lookup lists;
- dial codes;
- pagination и retry limits.

Запрещены параллельные файлы:

```text
locale_constants.dart
local_storage_consts.dart
profile_constants.dart
validation_consts.dart
analytics_constants.dart
```

Private constant, используемая только одним implementation-классом, остаётся
рядом с этим классом:

```dart
static const _authorizationHeader = 'Authorization';
```

Endpoints и navigation paths не помещаются в constants-файл.

## API endpoints

Во всём модуле допускается один endpoint-файл:

```text
lib/src/common/config/<module_name>_api_endpoints.dart
```

Пример:

```dart
abstract final class ClientProfileApiEndpoints {
  static const profile = '/users/me/profile';
  static const avatar = '/users/me/avatar';
  static const accountDeletion = '/users/me/delete-request';
  static const sessions = '/auth/sessions';

  static String session(String sessionId) => '$sessions/$sessionId';
}
```

Правила:

- endpoints всех внутренних features находятся в одном файле;
- class называется `<ModuleName>ApiEndpoints`;
- parameterized endpoints оформляются methods;
- файл импортируется только data layer этого модуля;
- файл не экспортируется;
- feature-level `configs/` и дополнительные endpoints-файлы запрещены.

## Navigation paths

Во всём модуле допускается один path-файл:

```text
lib/src/common/config/<module_name>_navigation_paths.dart
```

Пример:

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

Правила:

- class называется `<ModuleName>NavigationPaths`;
- все paths модуля находятся в одном файле;
- paths не объявляются непосредственно в router;
- paths не смешиваются с general constants;
- feature-level path-файлы запрещены;
- файл остаётся внутренним, если внешний path contract не требуется;
- для navigation events предпочтительны generated `PageRouteInfo`.

## Dependency injection

DI всегда находится в:

```text
lib/src/common/config/di/
├── <module_name>_di.dart
└── <module_name>_di.module.dart
```

Пример:

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

Правила:

- используется constructor injection;
- module services регистрируются через `injectable` annotations;
- core-owned dependencies перечисляются в `ignoreUnregisteredTypes`;
- приложение подключает generated `<ModuleName>PackageModule`;
- приложение не регистрирует вручную repositories, use cases, data sources и
  BLoCs модуля;
- generated `*.module.dart` не редактируется вручную.

## Routing

Если модуль владеет navigable screens, router находится в:

```text
lib/src/common/config/router/
├── <module_name>_router.dart
└── <module_name>_router.gr.dart
```

Пример:

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

Правила:

- используется AutoRoute;
- navigable screen имеет `@RoutePage()`;
- screen-файл заканчивается на `_screen.dart`;
- screen class заканчивается на `Screen`;
- generated route class заканчивается на `Route`;
- router читает paths только из module path-файла;
- root route composition остаётся в приложении;
- пустой router wrapper не создаётся;
- generated `*.gr.dart` не редактируется вручную.

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

Data layer отвечает за:

- API и local storage calls;
- serialization;
- request/response models;
- model/domain mapping;
- exception handling;
- repository implementations.

Exceptions не выходят за границу repository implementation. Они преобразуются
в `Failure`.

### Domain

```text
domain/
├── analytics/
├── entities/
├── repositories/
├── services/
└── usecases/
```

Domain layer отвечает за:

- business entities;
- repository contracts;
- use cases;
- domain services;
- typed analytics events.

Domain не импортирует Flutter, data models или presentation.

Analytics tracking выполняется внутри use cases, а не в BLoCs и data sources.

### Presentation

```text
presentation/
├── blocs/
├── extensions/
├── helpers/
├── screens/
└── widgets/
```

Presentation layer отвечает за:

- BLoC state management;
- screens;
- feature widgets;
- UI-only extensions;
- validation и formatting helpers.

Presentation не импортирует data layer.

## Models и mappers

Serializable model находится в собственной папке:

```text
data/models/session_model/
├── session_model.dart
└── session_model.g.dart
```

Правила:

- model class имеет suffix `Model`;
- model file и directory имеют одинаковое base name;
- JSON generation выполняется через `json_serializable`;
- `_json.dart` не используется вместо request/response model;
- mapping не находится в screens, BLoCs или data sources;
- отдельный mapper размещается в `data/mappers`, если преобразование не
  выражено самим model contract.

## BLoCs

Используется только `presentation/blocs`, не `presentation/bloc`.

```text
presentation/blocs/<topic>/
├── <topic>_bloc.dart
├── <topic>_event.dart
├── <topic>_state.dart
└── <topic>_bloc.freezed.dart
```

Например:

```text
presentation/blocs/user_profile/
├── user_profile_bloc.dart
├── user_profile_event.dart
├── user_profile_state.dart
└── user_profile_bloc.freezed.dart
```

Directory не повторяет suffix `_bloc`:

```text
blocs/user_profile/       # правильно
blocs/user_profile_bloc/  # неправильно
```

Правила:

- используется `Bloc<Event, State>`, не Cubit;
- bloc, event и state находятся в разных файлах;
- BLoC использует domain entities и use cases;
- data models не импортируются;
- async state моделируется через `StateStatus`;
- editable inputs моделируются через `FieldState<T>`;
- generated Freezed-файлы не редактируются вручную.

## Localization

Каждый модуль владеет одним ARB-набором:

```text
lib/l10n/<module_name>_en.arb
lib/l10n/<module_name>_kk.arb
lib/l10n/<module_name>_ru.arb
```

Правила:

- во всех locales одинаковый набор keys;
- модуль содержит только используемые им строки;
- строки sibling-модулей не дублируются;
- app composition strings остаются в приложении;
- UI использует `context.l10n`;
- consuming app регистрирует localization delegate каждого модуля;
- context extension не экспортируется.

Канонический `l10n.yaml`:

```yaml
arb-dir: lib/l10n
template-arb-file: <module_name>_en.arb
output-dir: lib/gen/l10n
output-localization-file: <module_name>_localizations.dart
output-class: <ModuleName>Localizations
nullable-getter: false
```

## Public package API

Единственный package entry point:

```text
lib/<module_name>.dart
```

Допустимые exports:

- generated localization class, если приложению нужен delegate;
- DI initializer и generated package module;
- public route classes и route lists;
- BLoCs, которые создаёт или наблюдает приложение;
- entities в public signatures;
- widgets, используемые app-level composition.

Запрещённые exports:

- `<module_name>_context_x.dart`;
- `gen/assets.gen.dart`;
- handwritten asset classes, facades и wrappers;
- feature-specific theme extension без явного внешнего контракта;
- constants;
- API endpoints;
- navigation paths без явного public contract;
- data sources;
- repository implementations;
- internal services;
- internal mappers и helpers;
- internal use cases;
- generated JSON и Freezed files.

После перемещения или удаления source-файла stale export удаляется сразу.

## Generator configuration

`build.yaml` всех модулей использует одинаковые paths и options:

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

AutoRoute builders не добавляются в модуль без routes. FlutterGen builder
обязателен для каждого feature-модуля: asset API никогда не пишется вручную.

## Pubspec

Правила для `pubspec.yaml`:

- workspace package использует `resolution: workspace`;
- dependency groups имеют одинаковый порядок;
- добавляются только реально используемые dependencies;
- после переноса feature старые dependencies удаляются;
- generator dependency добавляется только вместе с соответствующим builder;
- `flutter.generate` включён для localization;
- module assets объявлены package-local path.

## Tests

Tests зеркалируют source features:

```text
test/features/<feature_name>/
├── data/
├── domain/
└── presentation/
```

В зависимости от изменения добавляются:

- model parsing tests;
- mapper tests;
- repository tests;
- use-case tests;
- BLoC tests;
- route/path tests;
- localization/context widget smoke tests.

Пустые и устаревшие test directories удаляются после переноса feature.

## Module README

Каждый feature-модуль содержит `README.md` со следующими разделами:

- ответственность модуля;
- внутренние features;
- public API;
- external DI dependencies;
- routes;
- endpoints;
- assets;
- localization;
- запрещённые зависимости.

## Пример разделения client auth/profile

`client_auth` владеет только процессом авторизации:

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

`client_profile` владеет данными и состоянием текущего клиента:

```text
features/
├── profile/
├── account_status/
└── sessions/
```

В `client_profile` находятся:

- current user/profile loading;
- profile registration;
- profile editing;
- avatar operations;
- account deletion request;
- blocked/deletion-requested presentation;
- device sessions.

В `client_auth` не должны оставаться profile/session endpoints, localization,
routes, DI registrations, assets, dependencies или exports.

## Checklist нового модуля

Новый модуль создаётся repository generator tool:

```bash
dart run tools/generation/create_feature_module.dart <module_name>
```

При необходимости имя первой feature-зоны задаётся отдельно:

```bash
dart run tools/generation/create_feature_module.dart admin_reports \
  --feature reports
```

Dart tool валидирует `snake_case`, не перезаписывает существующий package,
добавляет модуль в root workspace, создаёт canonical scaffold и запускает
localization, FlutterGen, DI generation, format и analyze. `--no-codegen`
используется только когда генерация намеренно будет выполнена позже.

- [ ] Package добавлен в root workspace.
- [ ] Package добавлен в dependencies consuming app.
- [ ] Создан минимальный public barrel.
- [ ] Создан `<module_name>_context_x.dart`.
- [ ] Добавлены `context.l10n` и `context.assets`.
- [ ] Общие design-system assets используются через `context.designAssets`.
- [ ] Создан собственный `assets/` root.
- [ ] Настроен FlutterGen; `context.assets` возвращает generated module group.
- [ ] Нет рукописных asset classes, facades, wrappers и строковых путей.
- [ ] Создан собственный ARB-набор.
- [ ] Настроен `l10n.yaml`.
- [ ] Создан один constants-файл при наличии module constants.
- [ ] Создан один endpoints-файл при наличии remote API.
- [ ] Создан один paths-файл при наличии routes.
- [ ] Настроен micro-package DI.
- [ ] External core dependencies добавлены в `ignoreUnregisteredTypes`.
- [ ] Router создан только при наличии navigable screens.
- [ ] Features разделены на data/domain/presentation.
- [ ] Добавлена mirrored test structure.
- [ ] Создан module README.
- [ ] Нет imports из `src/` других modules.
- [ ] Нет exports context/assets/internal config.
- [ ] Feature theme extension добавлен только при отсутствии подходящих
      design-system tokens.

## Checklist перемещения feature

- [ ] Source перенесён в нового владельца.
- [ ] Package imports заменены на новый module name.
- [ ] Endpoints объединены в endpoint-файл нового модуля.
- [ ] Constants объединены в constants-файл нового модуля.
- [ ] Paths объединены в path-файл нового модуля.
- [ ] Localization keys и assets перенесены новому владельцу.
- [ ] DI registrations перенесены и перегенерированы.
- [ ] Routes перенесены и перегенерированы.
- [ ] Public API consuming apps обновлён.
- [ ] Старые exports удалены.
- [ ] Старые dependencies удалены.
- [ ] Старые localization keys и generated registrations отсутствуют.
- [ ] Пустые folders удалены.
- [ ] Tests перенесены или добавлены.

## Проверка изменений

Команды запускаются из конкретного package root.

После изменения workspace или pubspec:

```sh
flutter pub get
```

После изменения ARB или `l10n.yaml`:

```sh
flutter gen-l10n
```

После перемещения файлов между packages или изменения DI, routes, Freezed и
JSON models:

```sh
dart run build_runner clean
dart run build_runner build
```

Форматирование и анализ:

```sh
dart format lib test
flutter analyze lib
```

Тесты:

```sh
flutter test
```

При изменении public API, DI, routes, localization delegates или assets также
проверяется consuming app:

```sh
flutter analyze lib
flutter test
flutter build apk --debug
```

Перенос feature не считается завершённым, пока старый модуль содержит imports,
endpoints, constants, paths, localization keys, assets, dependencies, generated
registrations или exports, принадлежащие новому модулю.
