import 'package:core/api/api.dart';

class ApiException implements Exception {
  const ApiException({required this.type, this.response, this.error});

  final ApiExceptionType type;
  final ApiResponse<dynamic>? response;
  final Object? error;
}

enum ApiExceptionType {
  cancel,
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  connectionError,
  badCertificate,
  badResponse,
  unknown,
}
