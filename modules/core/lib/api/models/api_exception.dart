import 'package:core/api/api.dart';

class ApiException implements Exception {
  final ApiExceptionType type;
  final ApiResponse? response;
  final Object? error;

  const ApiException({required this.type, this.response, this.error});
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
