# admin_profile

## Responsibility

Owns the current admin user, profile creation and editing, avatar operations, sessions, and account-status presentation.

## Features

- `profile`: current user, registration, editing, and avatar operations;
- `sessions`: device list and session revocation;
- `account_status`: blocked and deletion-requested states.

## Public API

- localization delegate and DI package module;
- root route list and generated route classes;
- user/profile BLoCs observed by the app;
- profile-edit and devices views used by app-level dialogs.

## External DI dependencies

- named protected `ApiClient`;
- token storage, package information, and analytics services from `core`.

## Routes

- `register`;
- `blocked`;
- `deletion-requested`.

## Endpoints

Private paths in `admin_profile_api_endpoints.dart` cover the current user, profile, avatar, account deletion, and sessions.

## Assets

Module assets belong under `assets/admin_profile/` and are exposed internally through `context.assets`.

## Localization

English, Kazakh, and Russian ARB files generate `AdminProfileLocalizations`; module widgets use `context.l10n`.

## Forbidden dependencies

The module must not depend on `admin_app`, another feature module, or another package's `src/` tree.
