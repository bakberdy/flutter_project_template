import 'package:core/api/models/api_request.dart';

class ApiResponse<T> {
  const ApiResponse({
    required this.statusCode,
    this.data,
    this.statusMessage,
    this.headers = const {},
    this.request,
  });
  final T? data;
  final int statusCode;
  final String? statusMessage;
  final Map<String, dynamic> headers;
  final ApiRequest? request;

  bool get isSuccessful => statusCode >= 200 && statusCode < 300;
}
