# admin_auth

Admin authentication feature module. It owns the admin login domain, data access, authentication BLoC, localization, DI, constants, endpoints, and module assets.

Public API is limited to DI registration and `AuthBloc`. Internal localization and assets are available through `context.l10n` and `context.assets` inside the package.

