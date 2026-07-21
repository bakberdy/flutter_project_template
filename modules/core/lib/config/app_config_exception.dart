class AppConfigException implements Exception {
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
  const AppConfigException._(this.message);

  final String message;

  @override
  String toString() => 'AppConfigException: $message';
}
