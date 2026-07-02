class ApiConfig {
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  final Map<String, String> defaultHeaders;
  final List<String> publicPaths;
  final String refreshPath;
  final bool enableAuthInterceptor;

  const ApiConfig({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    this.publicPaths = const [],
    this.refreshPath = '/auth/refresh',
    this.enableAuthInterceptor = true,
  });

  ApiConfig copyWith({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, String>? defaultHeaders,
    List<String>? publicPaths,
    String? refreshPath,
    bool? enableAuthInterceptor,
  }) {
    return ApiConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      defaultHeaders: defaultHeaders ?? this.defaultHeaders,
      publicPaths: publicPaths ?? this.publicPaths,
      refreshPath: refreshPath ?? this.refreshPath,
      enableAuthInterceptor:
          enableAuthInterceptor ?? this.enableAuthInterceptor,
    );
  }
}
