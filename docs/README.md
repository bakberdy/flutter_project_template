# Документация проекта

## Архитектура

- [Структура feature-модулей](architecture/feature-module-structure.md) —
  каноническая структура, ownership, context extensions, assets, localization,
  design-system assets, feature theme extensions, constants, endpoints,
  navigation paths, DI, routing, public API, generators, tests и checklist
  миграции модулей. Документ также описывает использование
  `dart run tool/generation/create_feature_module.dart` для создания нового
  модуля.

## Module dependency rules

Local module dependency rules are configured in the repository-root
`architecture.yaml`. Each entry under `groups` names a reusable set of local
modules. A module's `allow.groups` list determines which of those sets it may
declare in `dependencies`, `dev_dependencies`, or `dependency_overrides`.
Dependencies whose names are not configured under `modules` are external and
are ignored.

Run the validator from the repository root:

```bash
dart run tool/validation/validate_module_dependencies.dart
```

When adding a module, add its package name and path under `modules`, place it in
the appropriate group, and configure its `allow.groups`. To allow a new local
dependency, add the dependency's group to the consuming module's
`allow.groups`. Feature-to-feature dependencies remain forbidden unless a
narrow group is explicitly configured and allowed for that consumer.
