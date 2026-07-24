# My App admin app

My App web administration panel. This app is web-only and uses a persistent
sidebar with nested URL navigation.

Run from this directory:

```sh
flutter run -d chrome --dart-define-from-file=config/config.development.json
```

Build the production website:

```sh
flutter build web --dart-define-from-file=config/config.production.json
```
