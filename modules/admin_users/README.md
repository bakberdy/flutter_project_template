# admin_users

## Responsibility

Owns admin user management: listing, filtering, details, role/status changes, and deletion-request approval.

## Features

- `users`: paginated user list and user details flow.

## Public API

- localization delegate and DI package module;
- module router and generated route classes.

## External DI dependencies

- named protected `ApiClient` and shared request/error handling primitives from `core`.

## Routes

- `users` for the list;
- `users/:userId` for details.

## Endpoints

Private paths in `admin_users_api_endpoints.dart` cover list/detail/profile requests and user mutations.

## Assets

Module assets belong under `assets/admin_users/` and are exposed internally through `context.assets`.

## Localization

English, Kazakh, and Russian ARB files generate `AdminUsersLocalizations`; module widgets use `context.l10n`.

## Forbidden dependencies

The module must not depend on `admin_app`, another feature module, or another package's `src/` tree.
