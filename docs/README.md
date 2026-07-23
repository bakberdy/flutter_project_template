# Project Documentation

## Architecture

- [Workspace structure](architecture/workspace_structure.md) — locations of
  applications, modules, and technical packages.
- [Feature modules](architecture/feature-module-structure.md) — canonical
  `common` and internal feature structure, layers, dependencies,
  configuration, DI, routing, public API, and module acceptance criteria.

## Module dependency rules

Local module dependency rules are configured in the repository-root
`architecture.yaml`.

- Business modules may depend only on `core`, `design_system`, and `shared`.
- Feature-to-feature dependencies are forbidden.
- `core` and `design_system` do not depend on local modules.
- `shared` may depend only on `core` and `design_system`.
- Applications compose business modules through their public APIs.

The analyzer checks `dependencies`, `dev_dependencies`, and
`dependency_overrides`. Packages not listed under `architecture.yaml.modules`
are treated as external dependencies.

Run analysis from the repository root:

```bash
dart analyze
```

When adding a business module:

1. Add it to the root workspace.
2. Add its name and path under `architecture.yaml.modules`.
3. Add it to the `features` group.
4. Allow only the `core`, `ui`, and `shared` groups.
