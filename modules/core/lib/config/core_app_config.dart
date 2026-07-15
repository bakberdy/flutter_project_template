abstract interface class CoreAppConfig {
  String get baseUrl;
  String get environment;
  Duration get connectTimeout;
  Duration get receiveTimeout;
  Duration get sendTimeout;
}
