# admin_preferences

## Responsibility

Owns admin locale, theme, and notification preferences, including persistence, remote synchronization, presentation widgets, localization, and DI.

## Features

- `user_preferences`: locale, theme, and notification settings.

## Public API

- localization delegate and supported-locale configuration;
- DI package module and accept-language header provider;
- locale and theme BLoCs observed by the app;
- preferences and notifications dialog views used by app composition.

## External DI dependencies

- named protected `ApiClient`;
- local preferences storage and analytics services from `core`.

## Routes

The module has no navigable screens. The admin app presents its public views inside web dialogs.

## Endpoints

Private paths in `admin_preferences_api_endpoints.dart` cover reading and updating user preferences.

## Assets

Module assets belong under `assets/admin_preferences/` and are exposed internally through `context.assets`.

## Localization

English, Kazakh, and Russian ARB files generate `AdminPreferencesLocalizations`; module widgets use `context.l10n`.

## Forbidden dependencies

The module must not depend on `admin_app`, another feature module, or another package's `src/` tree.
