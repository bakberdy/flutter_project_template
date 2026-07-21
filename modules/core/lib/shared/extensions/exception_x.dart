import 'package:core/api/models/api_exception.dart';
import 'package:core/domain/failures/failure.dart';
import 'package:core/shared/mappers/http_error_mapper.dart';
import 'package:core/shared/models/http_error_model.dart';
import 'package:core/utils/typedef.dart';

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
      if (data != null) {
        try {
          error = HttpErrorModel.fromJson(data);
        } on Object catch (_) {
          error = null;
        }
      }
      return error?.toFailure(source) ??
          RequestFailedFailure(
            source: source,
            details: FailureDetails(statusCode: e.response?.statusCode ?? 0),
          );
    }
    if (e is FormatException || e is TypeError) {
      return InvalidResponseFailure(source: source);
    }
    return UnknownFailure(source: source);
  }

  Failure? _clientApiFailure(ApiException e, String source) {
    return switch (e.type) {
      ApiExceptionType.connectionError when e.isServiceUnavailable =>
        ServiceUnavailableFailure(
          source: source,
          details: const FailureDetails(statusCode: 503),
        ),
      ApiExceptionType.connectionError => NoConnectionFailure(
        source: source,
        details: const FailureDetails(statusCode: 0),
      ),
      ApiExceptionType.connectionTimeout ||
      ApiExceptionType.receiveTimeout ||
      ApiExceptionType.sendTimeout => TimeoutFailure(
        source: source,
        details: const FailureDetails(statusCode: 503),
      ),
      ApiExceptionType.badCertificate => SecureConnectionFailure(
        source: source,
      ),
      ApiExceptionType.unknown => UnknownFailure(source: source),
      ApiExceptionType.badResponse when e.response?.statusCode == 503 =>
        ServiceUnavailableFailure(
          source: source,
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
