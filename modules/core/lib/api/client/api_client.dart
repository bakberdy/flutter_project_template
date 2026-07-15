import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../internal/auth_interceptor.dart';
import '../internal/auth_token_refresher.dart';
import '../internal/extensions.dart';
import '../models/api_cancel_token.dart';
import '../models/api_form_data.dart';
import '../models/api_options.dart';
import '../models/api_progress_callback.dart';
import '../models/api_response.dart';
import '../storage/token_storage.dart';
import 'api_config.dart';
import 'api_request_headers_provider.dart';

part 'api_client_factory.dart';

class ApiClient {
  ApiClient._(this._dio);

  final Dio _dio;

  Future<ApiResponse<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
    ApiProgressCallback? onReceiveProgress,
  }) => _send(
    () => _dio.get<T>(
      path,
      data: _normalizeData(data),
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<ApiResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
    ApiProgressCallback? onSendProgress,
    ApiProgressCallback? onReceiveProgress,
  }) => _send(
    () => _dio.post<T>(
      path,
      data: _normalizeData(data),
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<ApiResponse<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
    ApiProgressCallback? onSendProgress,
    ApiProgressCallback? onReceiveProgress,
  }) => _send(
    () => _dio.put<T>(
      path,
      data: _normalizeData(data),
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<ApiResponse<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
    ApiProgressCallback? onSendProgress,
    ApiProgressCallback? onReceiveProgress,
  }) => _send(
    () => _dio.patch<T>(
      path,
      data: _normalizeData(data),
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<ApiResponse<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
  }) => _send(
    () => _dio.delete<T>(
      path,
      data: _normalizeData(data),
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
    ),
  );

  Future<ApiResponse<T>> head<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
  }) => _send(
    () => _dio.head<T>(
      path,
      data: _normalizeData(data),
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
    ),
  );

  Future<ApiResponse> download(
    String urlPath,
    dynamic savePath, {
    ApiProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    ApiCancelToken? cancelToken,
    bool deleteOnError = true,
    Object? data,
    ApiOptions? options,
  }) => _send(
    () => _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken?.toCancelToken(),
      deleteOnError: deleteOnError,
      data: _normalizeData(data),
      options: options?.toOptions(),
    ),
  );

  // ── Internal ────────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> _send<T>(Future<Response<T>> Function() call) async {
    try {
      final response = await call();
      return response.toApiResponse<T>();
    } on DioException catch (e) {
      throw e.toApiException();
    } catch (e) {
      rethrow;
    }
  }

  Object? _normalizeData(Object? data) {
    if (data is! ApiFormData) {
      return data;
    }

    return FormData.fromMap(
      data.toMap().map((key, value) {
        if (value is ApiMultipartFile) {
          return MapEntry(
            key,
            MultipartFile.fromBytes(
              value.bytes,
              filename: value.filename,
              contentType: value.contentType == null
                  ? null
                  : DioMediaType.parse(value.contentType!),
            ),
          );
        }
        return MapEntry(key, value);
      }),
    );
  }
}
