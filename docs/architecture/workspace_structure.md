# Workspace Structure

```text
workspace/
├── apps/
│   ├── client_app/
│   └── admin_app/
│
├── modules/
│   ├── core/
│   ├── design_system/
│   ├── shared/
│   ├── client_auth/
│   ├── admin_auth/
│   └── ...
│
└── packages/
    ├── project_lints/
    ├── native_logger/
    ├── code_generators/
    └── ...
```

## apps/

Runnable applications.

Contains application composition, entry points, environment configuration, dependency injection setup, and feature integration.

## modules/

Business and platform modules.

Contains reusable application modules such as `core`, `design_system`, `shared`, and feature modules. Modules implement business logic and UI, and can be shared across multiple applications.

The module dependencies you can watch on 

## packages/

Technical libraries and developer tooling.

Contains reusable packages that are independent of the product domain, such as custom lints, code generators, plugins, utilities, and developer tools.