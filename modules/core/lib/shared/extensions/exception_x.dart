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
            message: _FailureMessages.requestError,
            source: source,
            details: FailureDetails(statusCode: e.response?.statusCode ?? 0),
          );
    }
    if (e is FormatException || e is TypeError) {
      return Failure(message: _FailureMessages.responseParse, source: source);
    }
    return Failure(message: _FailureMessages.unexpected, source: source);
  }

  Failure? _clientApiFailure(ApiException e, String source) {
    return switch (e.type) {
      ApiExceptionType.connectionError ||
      ApiExceptionType.connectionTimeout ||
      ApiExceptionType.receiveTimeout ||
      ApiExceptionType.sendTimeout => Failure(
        message: _FailureMessages.internetConnection,
        source: source,
        details: const FailureDetails(statusCode: 0),
      ),
      ApiExceptionType.badCertificate => Failure(
        message: _FailureMessages.secureConnection,
        source: source,
      ),
      ApiExceptionType.unknown => Failure(
        message: _FailureMessages.unexpected,
        source: source,
      ),
      ApiExceptionType.cancel || ApiExceptionType.badResponse => null,
    };
  }
}

abstract final class _FailureMessages {
  static const String internetConnection = 'No internet connection';
  static const String requestError = 'Request failed';
  static const String secureConnection = 'Secure connection failed';
  static const String responseParse = 'Failed to parse response';
  static const String unexpected = 'Unexpected error';
}
