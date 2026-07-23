# Session Navigation Guidelines

These instructions are mandatory for tasks involving logout, account deletion,
or navigation caused by user/session state changes.

## Logout

Treat logout as an explicit user action. Whenever the user can see and activate
a localized logout label, dispatch `CoreNavigationEvent.loggedOut()` through
`CoreNavigationBloc`.

Never use the logout event for account deletion or any other non-logout
operation.

## Other Account-State Changes

After account deletion or another non-logout operation changes the current
user's state, dispatch `CoreNavigationEvent.refreshUser()` through
`CoreNavigationBloc`.
