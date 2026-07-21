import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class Failure extends Equatable {

  const Failure({
    required this.source, this.message,
    this.reason = FailureReason.unknown,
    this.details,
  });

  factory Failure.requestCancelled(String source) {
    return Failure(
      source: source,
      reason: FailureReason.cancelled,
      details: const FailureDetails(statusCode: 0, type: FailureType.silent),
    );
  }
  final String? message;
  final String source;
  final FailureReason reason;
  final FailureDetails? details;

  @override
  List<Object?> get props => [message, source, reason, details];
}

enum FailureReason {
  backend,
  noConnection,
  timeout,
  serviceUnavailable,
  secureConnection,
  invalidResponse,
  requestFailed,
  unauthorized,
  cancelled,
  unknown,
}

class FieldFailure {
  const FieldFailure({required this.fieldName, required this.message});

  final String fieldName;
  final String message;
}

class FailureDetails {
  const FailureDetails({
    required this.statusCode,
    this.fieldErrors,
    this.type = FailureType.snackbar,
  });

  final int statusCode;
  final List<FieldFailure>? fieldErrors;
  final FailureType type;
}

enum FailureType {
  //info
  @JsonValue('snackbar')
  snackbar,

  //warning
  @JsonValue('banner')
  banner,
  @JsonValue('inline')
  inline,

  //critical
  @JsonValue('alert')
  alert,
  @JsonValue('full_screen')
  fullScreen,

  //no need to show
  @JsonValue('silent')
  silent,
}
