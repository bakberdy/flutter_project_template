# core/api

Self-contained HTTP module. External dependencies: **Dio** and **flutter\_secure\_storage** only.  
No knowledge of `AppConfig`, `injectable`, or any feature layer.

---

## Folder structure

```
api/
  api.dart                      ← single import point for the rest of the app
  README.md
  client/
    api_client.dart             ← ApiClient
    api_config.dart             ← ApiConfig (value object)
  models/
    api_cancel_token.dart       ← ApiCancelToken
    api_exception.dart          ← ApiException hierarchy
    api_options.dart            ← per-request options
    api_progress_callback.dart  ← typedef ApiProgressCallback
    api_request.dart            ← ApiRequest (attached to every response)
    api_response.dart           ← ApiResponse<T>
  storage/
    token_storage.dart          ← TokenStorage (abstract interface)
    token_storage_impl.dart     ← TokenStorageImpl (FlutterSecureStorage)
  internal/                     ← never import from outside api/
    auth_interceptor.dart
    dio_adapter.dart
    dio_exception_mapper.dart
```

---

## Import

Outside of `core/api/` always import through the barrel:

```dart
import 'package:core/api/api.dart';
```

Never import from `internal/` directly.

---

## `ApiConfig`

All fields except `baseUrl` are optional:

```dart
final config = ApiConfig(
  baseUrl: 'https://api.example.com/v1',

  connectTimeout: Duration(seconds: 30), // default
  receiveTimeout: Duration(seconds: 30), // default
  sendTimeout:    Duration(seconds: 30), // default

  defaultHeaders: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
);
```

---

## `ApiClient`

```dart
final protectedApi = apiClientFactory.createProtected(config: config);
final publicApi = apiClientFactory.createPublic(config: config);
```

Multiple independent clients are supported:

```dart
final mainApi = apiClientFactory.createProtected(config: mainConfig);
final cdnApi = apiClientFactory.createPublic(config: cdnConfig);
```

---

## Making requests

Every method returns `ApiResponse<T>` and throws an `ApiException` subclass on failure — never a raw `DioException`.

```dart
// GET
final res = await api.get<Json>('/trips');

// GET with query parameters
final res = await api.get<Json>(
  '/trips',
  queryParameters: {'page': 1, 'limit': 20},
);

// POST
final res = await api.post<Json>('/trips', data: body);

// PUT / PATCH / DELETE
final res = await api.put<Json>('/trips/1',  data: body);
final res = await api.patch<Json>('/trips/1', data: patch);
final res = await api.delete<void>('/trips/1');

// HEAD
final res = await api.head('/trips/1');
```

### `ApiResponse<T>`

```dart
res.data          // T? — decoded response body
res.statusCode    // int
res.statusMessage // String?
res.headers       // Map<String, String>
res.request       // ApiRequest? — echoes back the original request
res.isSuccessful  // true when 200–299
```

---

## `ApiCancelToken`

Create one token per request (or per screen) and cancel it when no longer needed.

```dart
final cancel = ApiCancelToken();

// pass to any method
final res = await api.get(
  '/trips',
  cancelToken: cancel,
);

// cancel from anywhere (e.g. dispose / bloc close)
cancel.cancel('user left screen');

// check state if needed
if (cancel.isCancelled) { ... }
```

Cancelled requests throw `ApiCancelledException` — catch it separately if you want to suppress the error:

```dart
try {
  final res = await api.get('/trips', cancelToken: cancel);
} on ApiCancelledException {
  // request was cancelled — usually safe to ignore
} on ApiException catch (e) {
  // other errors
}
```

---

## `ApiOptions` — per-request overrides

```dart
// file upload with progress
await api.post(
  '/media',
  data: formData,
  options: ApiOptions(
    contentType: 'multipart/form-data',
    sendTimeout: Duration(minutes: 5),
  ),
  onSendProgress: (sent, total) {
    final percent = (sent / total * 100).toStringAsFixed(1);
    print('Upload: $percent%');
  },
);

// custom headers for a single request
await api.get(
  '/protected',
  options: ApiOptions(
    headers: {'X-Api-Key': secret},
  ),
);

// disable redirect following
await api.get(
  '/redirect-check',
  options: ApiOptions(followRedirects: false),
);
```

`ApiOptions` fields:

| Field | Type | Default |
|---|---|---|
| `headers` | `Map<String, dynamic>?` | — |
| `contentType` | `String?` | — |
| `sendTimeout` | `Duration?` | from `ApiConfig` |
| `receiveTimeout` | `Duration?` | from `ApiConfig` |
| `extra` | `Map<String, dynamic>?` | — |
| `followRedirects` | `bool` | `true` |
| `maxRedirects` | `int` | `5` |

---

## File download

```dart
await api.download(
  '/reports/annual.pdf',
  '/storage/emulated/0/Download/annual.pdf',
  cancelToken: cancel,
  onReceiveProgress: (received, total) {
    if (total > 0) print('${(received / total * 100).toInt()}%');
  },
);
```

---

## `ApiException` hierarchy

Every exception has three fields:

```dart
e.message    // String — human-readable description
e.statusCode // int?  — HTTP status, null for network/timeout/cancel errors
e.data       // dynamic — raw response body from the server (null if not available)
```

| Type | `statusCode` | When thrown |
|---|---|---|
| `ApiNetworkException` | `null` | No connectivity / socket error |
| `ApiTimeoutException` | `null` | Connect / send / receive timeout |
| `ApiUnauthorizedException` | `401` | Refresh token rejected or missing after retry |
| `ApiRequestException` | `400` / `422` | Bad request or validation failure |
| `ApiServerException` | `403` / `404` / `429` / `5xx` | Server-side error |
| `ApiCancelledException` | `null` | Request cancelled via `ApiCancelToken` |
| `ApiUnknownException` | `null` | Anything else |

### Reading field-level validation errors from `data`

When the server returns a 400 or 422 with a structured body, the full raw body is available on `e.data`:

```dart
// server responds with:
// { "message": "Validation failed", "errors": { "email": ["is invalid"], "password": ["is too short"] } }

try {
  await api.post('/auth/register', data: body);
} on ApiRequestException catch (e) {
  final errors = (e.data as Json?)?['errors'] as Json?;

  final emailError    = (errors?['email']    as List?)?.first as String?;
  final passwordError = (errors?['password'] as List?)?.first as String?;
}
```

`data` is typed `dynamic` because response bodies vary by API. Cast safely before use.

---

## Error handling in a repository

```dart
Future<Either<Failure, List<Trip>>> getTrips() async {
  try {
    final res = await _dataSource.getTrips();
    return Right(res);
  } on Exception catch (e) {
    // ExceptionHandler maps ApiException subtypes → Failure
    return Left(ExceptionHandler.handle(e));
  }
}
```

---

## `TokenStorage`

The interface lives inside the api module. `TokenStorageImpl` is the built-in implementation backed by `flutter_secure_storage`. Keys stored:

| Key | Value |
|---|---|
| `auth_token` | access token |
| `refresh_token` | refresh token |
| `token_expiry` | expiry (cleared on `clearTokens`) |

To use a different storage backend, implement `TokenStorage` and register it in DI.

---

## DI wiring (injectable / get_it)

```dart
@module
abstract class AppModule {
  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();

  // TokenStorageImpl is registered automatically via @LazySingleton(as: TokenStorage)

  @lazySingleton
  ApiConfig get apiConfig => ApiConfig(
        baseUrl: AppConfig.instance.baseUrl,
      );

  @lazySingleton
  ApiClientFactory apiClientFactory(TokenStorage storage) =>
      ApiClientFactory(tokenStorage: storage);

  @lazySingleton
  @Named('protectedApiClient')
  ApiClient protectedApiClient(
    ApiConfig config,
    ApiClientFactory factory,
  ) =>
      factory.createProtected(config: config);

  @lazySingleton
  @Named('publicApiClient')
  ApiClient publicApiClient(
    ApiConfig config,
    ApiClientFactory factory,
  ) =>
      factory.createPublic(config: config);
}
```
