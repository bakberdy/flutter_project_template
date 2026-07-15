class AppConfigException implements Exception {
  const AppConfigException._(this.message);

  final String message;

  factory AppConfigException.missing(String name) {
    return AppConfigException._(
      'Missing required dart define: $name. '
      'Pass it with --dart-define=$name=... or '
      '--dart-define-from-file=config/config.<env>.json.',
    );
  }

  factory AppConfigException.invalid(
    String name,
    String value,
    String expected,
  ) {
    return AppConfigException._(
      'Invalid dart define $name=$value. Expected $expected.',
    );
  }

  @override
  String toString() => 'AppConfigException: $message';
}
