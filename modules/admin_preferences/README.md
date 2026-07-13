# admin_preferences

Admin preferences feature module. It owns locale, theme, and notification preferences, their persistence and synchronization, navigation, localization, DI, constants, endpoints, and module assets.

The public localization configuration is the single locale source of truth for the admin app. Internal context extensions expose module localization and assets as `context.l10n` and `context.assets` only inside the package.
