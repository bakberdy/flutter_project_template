# admin_auth

## Responsibility

Owns the complete admin sign-in flow: email and OTP presentation, authentication state, API access, token persistence, localization, DI, and routes.

## Features

- `auth`: login, OTP verification, refresh, logout, and notification-token registration.

## Public API

- localization delegate;
- DI package module;
- `adminAuthRoutes` and generated route classes.

## External DI dependencies

- named public and protected `ApiClient` instances;
- `TokenStorage`, `DeviceInfoService`, and analytics services from `core`.

## Routes

- `sign-in` with the initial email screen;
- `sign-in/otp` for code verification.

## Endpoints

All paths are private constants in `admin_auth_api_endpoints.dart` and cover login, verification, refresh, logout, and device notifications.

## Assets

Module assets belong under `assets/admin_auth/` and are available internally through `context.assets`.

## Localization

English, Kazakh, and Russian ARB files generate `AdminAuthLocalizations`; module widgets use `context.l10n`.

## Forbidden dependencies

The module must not depend on `admin_app`, another feature module, or another package's `src/` tree.
