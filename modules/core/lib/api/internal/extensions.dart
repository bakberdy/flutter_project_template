// ignore_for_file: document_ignores

import 'package:core/api/api.dart';
import 'package:dio/dio.dart';

extension DioExceptionX on DioException {
  ApiException toApiException() => ApiException(
    type: type.toApiExceptionType(),
    response: response?.toApiResponse(),
    error: error ?? message,
  );
}

extension DioExceptionTypeX on DioExceptionType {
  ApiExceptionType toApiExceptionType() => switch (this) {
    .badCertificate => .badCertificate,
    .badResponse => .badResponse,
    .cancel => .cancel,
    .connectionError => .connectionError,
    .transformTimeout => .unknown,
    .receiveTimeout => .receiveTimeout,
    .sendTimeout => .sendTimeout,
    .unknown => .unknown,
    .connectionTimeout => .connectionTimeout,
  };
}

extension DioResponseX<T> on Response<T> {
  ApiResponse<T> toApiResponse() => ApiResponse<T>(
    data: data,
    statusCode: statusCode ?? 0,
    statusMessage: statusMessage,
    headers: headers.map.map((key, values) => MapEntry(key, values.join(', '))),
    request: ApiRequest(
      path: requestOptions.path,
      method: requestOptions.method,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      headers: requestOptions.headers,
    ),
  );
}

extension ApiOptionsX on ApiOptions {
  Options? toOptions() => Options(
    headers: headers,
    contentType: contentType,
    sendTimeout: sendTimeout,
    receiveTimeout: receiveTimeout,
    extra: extra,
    followRedirects: followRedirects,
    maxRedirects: maxRedirects,
  );
}

extension OptionsX on Options {
  ApiOptions? toApiOptions() => ApiOptions(
    headers: headers,
    contentType: contentType,
    sendTimeout: sendTimeout,
    receiveTimeout: receiveTimeout,
    extra: extra,
    followRedirects: followRedirects,
    maxRedirects: maxRedirects,
  );
}

extension CancelTokenX on ApiCancelToken {
  CancelToken? toCancelToken() {
    final cancelToken = CancelToken();
    addCancelListener(cancelToken.cancel);
    return cancelToken;
  }
}
