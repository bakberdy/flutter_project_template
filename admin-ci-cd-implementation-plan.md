# План реализации CI/CD для Admin App

Статус: план реализации.

Цель: построить для Flutter Web Admin App CI/CD с такой же моделью
orchestration, проверок, release gates, immutable artifact, deployment и
rollback, как у backend, но полностью изолировать его от Client App.

Источник архитектурного подхода:
[`ci-cd-workflow-structure.md`](ci-cd-workflow-structure.md).

## Прогресс реализации

- [x] Создан отдельный pinned Flutter setup для Admin CI.
- [x] Создан reusable Admin application validation.
- [x] Создан reusable Admin repository security.
- [x] Создан PR-режим проверки Admin Web artifact.
- [x] Создан `Admin Delivery Gate` с Admin change scope.
- [x] Создан Terraform hosting contract для development и production.
- [x] Зафиксированы `dev.admin.bakberdi.dev` и `admin.bakberdi.dev`.
- [x] Реализована публикация immutable release artifact.
- [x] Реализованы Admin release tags и release orchestration.
- [x] Реализованы deployment, external health и automatic rollback.
- [x] GitHub Environments, variables и Admin ruleset описаны в Terraform.
- [x] ACM certificates созданы для обоих Admin domains.
- [x] Добавлены внешние DNS CNAME для ACM validation.
- [x] Выполнен AWS `terraform apply`; финальный plan показывает no changes.
- [x] Выполнен GitHub `terraform apply`.
- [x] Добавлены внешние Admin domain CNAME на CloudFront.
- [ ] Проверены development rollout, forced rollback и production approval.

Terraform root:
[`infra/terraform/admin_web`](infra/terraform/admin_web/README.md).

Client App workflow, store release, DNS и deployment не изменяются.

## 1. Обязательная изоляция Admin App

Admin CI/CD не должен изменять, собирать, публиковать или деплоить Client App.

Правила изоляции:

- все новые workflow имеют префикс `admin-`;
- required check называется `Admin Delivery Gate`;
- Admin release использует только теги `admin-vX.Y.Z-dev.N` и
  `admin-vX.Y.Z`;
- версия читается только из `apps/admin_app/pubspec.yaml`;
- Flutter Web собирается только из `apps/admin_app`;
- Client App workflow `release-on-publish.yml`,
  `android-upload-to-play.yml` и `ios-upload-to-testflight.yml` не изменяются и
  не вызываются;
- Admin secrets и variables имеют префикс `ADMIN_`;
- GitHub Environments называются `admin-development` и `admin-production`;
- build artifacts, AWS roles, buckets, CDN distributions и публичные URL
  принадлежат только Admin App;
- `apps/client_app` и `modules/client_*` не входят в Admin build и tests;
- изменения `core`, `shared` и `design_system` проверяются Admin pipeline,
  потому что эти пакеты являются зависимостями Admin App.

## 2. Целевая структура workflow

| Workflow | Тип | Ответственность |
| --- | --- | --- |
| `admin-delivery.yml` | PR orchestrator | Запустить Admin PR checks и сформировать `Admin Delivery Gate`. |
| `admin-project-validation.yml` | Reusable | Проверить качество, тесты и runtime-поведение Admin App. |
| `admin-repository-security.yml` | Reusable | Проверить секреты, зависимости, workflow и конфигурацию Admin CI/CD. |
| `admin-web-artifact.yml` | Reusable | Проверить PR build или создать immutable Flutter Web release artifact. |
| `admin-publish.yml` | Tag-release orchestrator | Проверить Admin release tag, собрать artifact и направить его в нужное environment. |
| `admin-deploy.yml` | Reusable и manual | Развернуть одобренный Admin artifact и выполнить rollback при ошибке. |

## 3. Триггеры

### Pull request

`admin-delivery.yml` запускается для:

```text
pull_request -> main:
  opened
  synchronize
  reopened
  ready_for_review

merge_group
```

Admin jobs должны запускаться, когда изменены:

- `apps/admin_app/**`;
- `modules/admin_*/**`;
- `modules/core/**`;
- `modules/shared/**`;
- `modules/design_system/**`;
- Admin workflow, action, validation или deployment configuration.

Изменение только `apps/client_app/**` или `modules/client_*/**` не должно
запускать Admin pipeline.

### Release

```text
admin-vX.Y.Z-dev.N -> admin-development
admin-vX.Y.Z       -> admin-production
```

Оба тега должны указывать на текущий `main` HEAD.

Не являются Admin trigger:

- обычный push в `main`;
- произвольный tag;
- Client App release;
- изменение только Client App;
- GitHub Release event, принадлежащий текущему mobile release workflow.

### Manual deployment

`admin-deploy.yml` поддерживает `workflow_dispatch` для повторного deployment
уже созданного immutable Admin artifact.

## 4. Шаг 1 — зафиксировать инфраструктурный контракт

Реализованный контракт:

- development URL: `https://dev.admin.bakberdi.dev`;
- production URL: `https://admin.bakberdi.dev`;
- отдельные private/versioned S3 buckets на environment;
- отдельные CloudFront distributions и ACM certificates;
- DNS validation и Admin domain CNAME создаются вручную во внешнем DNS;
- immutable paths `artifacts/sha256/<digest>.tar.gz` и
  `releases/<digest>/`;
- атомарное переключение через CloudFront KeyValueStore
  `active_release`;
- предыдущий KVS value используется для rollback;
- health проверяет публичный `release.json`;
- publish и каждый deploy используют отдельные Admin AWS OIDC roles.

Результат шага:

- утверждены `admin-development` и `admin-production`;
- известны все environment variables и secrets;
- deployment не использует Client App или backend resources.

## 5. Шаг 2 — реализовать Admin application validation

Создать `admin-project-validation.yml` с `workflow_call`.

Inputs:

- `source_sha` — полный SHA проверяемого commit;
- `base_sha` — база PR для определения затронутых пакетов;
- `mode` — `pr` или `release`.

Jobs:

1. `quality`
   - checkout точного `source_sha`;
   - проверить форматирование Admin и его зависимостей;
   - запустить analyzer для Admin dependency scope;
   - проверить hardcoded UI strings;
   - выполнить `git diff --check`.
2. `unit`
   - проверить `apps/admin_app`;
   - проверить затронутые `modules/admin_*`;
   - проверить затронутые `core`, `shared` и `design_system`;
   - не запускать `apps/client_app` и `modules/client_*`.
3. `runtime`
   - использовать только synthetic CI configuration;
   - собрать Flutter Web;
   - поднять локальный static server;
   - проверить загрузку `index.html`, основных assets и SPA fallback;
   - не обращаться к development или production backend.
4. `application-gate`
   - выполняться через `if: always()`;
   - вернуть success только при успехе всех обязательных jobs.

Для release повторно выполняется полный Admin validation точного tag SHA.

## 6. Шаг 3 — реализовать Admin repository security

Создать `admin-repository-security.yml` с `workflow_call`.

Jobs:

1. `secrets`
   - проверить Git history через pinned Gitleaks;
   - отклонить tracked файлы, которые должны быть ignored;
   - не выводить найденные секреты в лог.
2. `dependencies`
   - проверить Admin dependency graph и `pubspec.lock`;
   - использовать pinned OSV Scanner или другой утвержденный scanner;
   - блокировать недопустимые уязвимости.
3. `workflows`
   - проверить GitHub Actions через pinned `actionlint`;
   - проверить security policy через pinned `zizmor`;
   - запретить `secrets: inherit`;
   - требовать минимальные job-level permissions.
4. `configuration`
   - проверить Admin web и deployment configuration;
   - проверить Terraform/IaC после добавления инфраструктуры;
   - убедиться, что production config не хранится в Git.
5. `repository-security-gate`
   - вернуть success только при успехе всех security jobs.

Default permission:

```text
contents: read
```

## 7. Шаг 4 — реализовать immutable Flutter Web artifact

Создать `admin-web-artifact.yml` с режимами `pr` и `release`.

### PR mode

- checkout точного `source_sha`;
- использовать безопасную synthetic конфигурацию;
- выполнить `flutter build web --release` только для `apps/admin_app`;
- проверить структуру `build/web`;
- поднять static server;
- проверить entry page, assets и SPA routes;
- не использовать AWS credentials;
- не публиковать release artifact.

### Release mode

- принять только `admin-development` или `admin-production`;
- получить конфигурацию выбранного GitHub Environment;
- создать временный config вне tracked source;
- выполнить Admin Flutter Web release build;
- добавить release metadata с source SHA и environment;
- упаковать `build/web`;
- вычислить SHA-256 artifact digest;
- сформировать dependency/SBOM и security evidence;
- опубликовать artifact в immutable release storage;
- сохранить evidence как GitHub artifact;
- вернуть artifact reference, digest и evidence ID.

Из-за compile-time `String.fromEnvironment` development и production являются
разными artifacts:

```text
source SHA + environment config fingerprint
    -> один immutable Admin Web artifact
    -> один artifact digest
```

Config fingerprint не должен раскрывать значения secrets.

## 8. Шаг 5 — реализовать Admin PR orchestration

Создать `admin-delivery.yml`.

Параллельные reusable calls:

```text
Admin Application Validation ------+
                                  |
Admin Repository Security --------+--> Admin Delivery Gate
                                  |
Admin Web Artifact PR Check ------+
```

`Admin Delivery Gate`:

- зависит от всех трех calls;
- выполняется через `if: always()`;
- учитывает failure, cancelled и unexpected skipped;
- становится единственным Admin required check.

Concurrency:

```text
admin-delivery-pr-<PR number или ref>
cancel-in-progress: true
```

Новый commit в PR отменяет устаревший Admin run.

## 9. Шаг 6 — реализовать Admin release orchestration

Создать `admin-publish.yml`.

### `release-contract`

- разрешить только `admin-vX.Y.Z-dev.N` и `admin-vX.Y.Z`;
- определить target environment;
- получить текущий `main` HEAD;
- потребовать совпадение tag SHA и текущего `main` HEAD;
- прочитать версию из `apps/admin_app/pubspec.yaml`;
- запретить Client App tag и произвольный tag.

### Release flow

```text
release-contract
    |
    +--> admin-project-validation
    |
    +--> admin-repository-security
              |
              +--> admin-web-artifact: release
                          |
                          +--> admin-deploy
```

Release job не должен:

- менять `apps/client_app/pubspec.yaml`;
- вызывать mobile store workflows;
- использовать Client App secrets;
- пересобирать artifact внутри deployment.

Concurrency:

```text
admin-publish-<tag ref>
cancel-in-progress: false
```

## 10. Шаг 7 — реализовать Admin deployment и rollback

Создать `admin-deploy.yml` с `workflow_call` и `workflow_dispatch`.

Inputs:

- `target_environment`;
- `source_sha`;
- `artifact_reference`;
- `artifact_digest`;
- `security_evidence_id`.

Deployment:

1. Разрешить только `admin-development` или `admin-production`.
2. Проверить full source SHA и формат artifact digest.
3. Скачать security evidence из конкретного source run.
4. Повторно проверить связь SHA, environment, artifact и digest.
5. Получить short-lived AWS credentials через OIDC.
6. Проверить наличие immutable artifact в Admin storage.
7. Запомнить текущий active artifact.
8. Переключить Admin CDN на новый immutable release.
9. Выполнить cache invalidation.
10. Проверить публичный HTTPS URL, entry page и основной hashed asset.
11. При ошибке вернуть предыдущий artifact.
12. Повторить external health после rollback.
13. Вернуть `success`, `rolled_back` или `rollback_failed`.

Успешный rollback восстанавливает сайт, но исходный release run остается
failed.

Concurrency:

```text
admin-deploy-<environment>
cancel-in-progress: false
```

## 11. Шаг 8 — настроить GitHub Environments и permissions

Создать:

- `admin-development`;
- `admin-production`.

Для production включить required reviewers.

Environment secrets должны иметь Admin scope, например:

- `ADMIN_API_URL`;
- `ADMIN_ENABLE_LOGGING`;
- `ADMIN_ENABLE_ANALYTICS`;
- `ADMIN_ENABLE_CRASHLYTICS`;
- Admin timeout values;
- `ADMIN_AWS_ROLE_TO_ASSUME`, если role передается как secret.

Repository/environment variables:

- `ADMIN_AWS_REGION`;
- `ADMIN_WEB_BUCKET`;
- `ADMIN_CLOUDFRONT_DISTRIBUTION_ID`;
- `ADMIN_PUBLIC_URL`.

Permissions:

- validation/security/PR build: `contents: read`;
- release publication/deployment: `contents: read`, `actions: read` при
  необходимости и `id-token: write`;
- не использовать статические AWS access keys;
- не использовать `secrets: inherit`.

## 12. Шаг 9 — безопасно подключить pipeline

Порядок включения:

1. Добавить reusable validation и security workflow.
2. Добавить PR artifact check.
3. Подключить `admin-delivery.yml`.
4. Выполнить PR dry run.
5. Настроить `Admin Delivery Gate` в branch protection.
6. Добавить release artifact workflow.
7. Добавить development deployment.
8. Проверить успешный development rollout.
9. Искусственно вызвать health failure и проверить rollback.
10. Только после этого включить production deployment.

Существующие Client App workflow и triggers на этом шаге не изменять.

## 13. Финальная валидация

Перед завершением:

- проверить YAML всех новых workflow;
- запустить `actionlint`;
- запустить `zizmor`;
- проверить pinned actions и checksums загружаемых инструментов;
- выполнить Admin format, analyze, tests и hardcoded UI check;
- выполнить `git diff --check`;
- доказать, что Client-only PR не запускает Admin pipeline;
- доказать, что Admin tag не запускает Client App release;
- доказать, что Client tag/release не запускает Admin deployment;
- проверить development deployment;
- проверить automatic rollback;
- проверить production approval boundary;
- обновить отдельную фактическую карту Admin CI/CD после реализации.

## 14. Критерии готовности

Работа завершена, когда:

- Admin и Client App имеют независимые CI/CD pipelines;
- `Admin Delivery Gate` является единственным required check Admin pipeline;
- Admin releases запускаются только Admin tags;
- development и production используют отдельные защищенные environments;
- deployment принимает только проверенный immutable artifact;
- rollback проверен;
- Client App files, versions, secrets, artifacts и release workflows не
  затрагиваются.
