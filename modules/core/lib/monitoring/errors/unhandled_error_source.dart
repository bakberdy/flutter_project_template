enum UnhandledErrorSource {
  flutterFramework('flutter_framework'),
  platformDispatcher('platform_dispatcher'),
  zone('zone');

  const UnhandledErrorSource(this.reason);

  final String reason;
}
