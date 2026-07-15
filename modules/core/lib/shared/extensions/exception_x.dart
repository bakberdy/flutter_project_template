import 'package:core/shared/mappers/http_error_mapper.dart';
import 'package:core/shared/models/http_error_model.dart';
import 'package:core/utils/typedef.dart';

import '../../api/models/api_exception.dart';
import '../entities/failure.dart';

extension ExceptionX on Exception {
  Future<Failure> toFailure({required String source}) async {
    final e = this;
    if (e is ApiException) {
      final clientFailure = _clientApiFailure(e, source);
      if (clientFailure != null) {
        return clientFailure;
      }

      final responseData = e.response?.data;
      final data = responseData is DataMap ? responseData : null;
      HttpErrorModel? error;
      try {
        error = HttpErrorModel.fromJson(data ?? {});
      } catch (_) {
        error = null;
      }
      return error?.toFailure(source) ??
          Failure(
            source: source,
            reason: FailureReason.requestFailed,
            details: FailureDetails(statusCode: e.response?.statusCode ?? 0),
          );
    }
    if (e is FormatException || e is TypeError) {
      return Failure(source: source, reason: FailureReason.invalidResponse);
    }
    return Failure(source: source);
  }

  Failure? _clientApiFailure(ApiException e, String source) {
    return switch (e.type) {
      ApiExceptionType.connectionError when e.isServiceUnavailable => Failure(
        source: source,
        reason: FailureReason.serviceUnavailable,
        details: const FailureDetails(statusCode: 503),
      ),
      ApiExceptionType.connectionError => Failure(
        source: source,
        reason: FailureReason.noConnection,
        details: const FailureDetails(statusCode: 0),
      ),
      ApiExceptionType.connectionTimeout ||
      ApiExceptionType.receiveTimeout ||
      ApiExceptionType.sendTimeout => Failure(
        source: source,
        reason: FailureReason.timeout,
        details: const FailureDetails(statusCode: 503),
      ),
      ApiExceptionType.badCertificate => Failure(
        source: source,
        reason: FailureReason.secureConnection,
      ),
      ApiExceptionType.unknown => Failure(source: source),
      ApiExceptionType.badResponse when e.response?.statusCode == 503 =>
        Failure(
          source: source,
          reason: FailureReason.serviceUnavailable,
          details: const FailureDetails(statusCode: 503),
        ),
      ApiExceptionType.cancel || ApiExceptionType.badResponse => null,
    };
  }
}

extension _ApiExceptionServiceUnavailableX on ApiException {
  bool get isServiceUnavailable {
    final description = error.toString().toLowerCase();
    return description.contains('connection refused') ||
        description.contains('connection reset') ||
        description.contains('connection aborted') ||
        description.contains('connection closed') ||
        description.contains('http status error [503]');
  }
}
