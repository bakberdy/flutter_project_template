import 'package:core/domain/failures/field_failure.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.source,
    this.details,
  });

  factory Failure.requestCancelled(String source) => RequestCancelledFailure(
    source: source,
    details: const FailureDetails(statusCode: 0, type: FailureType.silent),
  );

  final String source;
  final FailureDetails? details;

  @override
  List<Object?> get props => [source, details];
}

final class BackendFailure extends Failure {
  const BackendFailure({
    required super.source,
    required this.message,
    super.details,
  });

  final String message;

  @override
  List<Object?> get props => [...super.props, message];
}

final class NoConnectionFailure extends Failure {
  const NoConnectionFailure({
    required super.source,
    super.details,
  });
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure({
    required super.source,
    super.details,
  });
}

final class ServiceUnavailableFailure extends Failure {
  const ServiceUnavailableFailure({
    required super.source,
    super.details,
  });
}

final class SecureConnectionFailure extends Failure {
  const SecureConnectionFailure({
    required super.source,
    super.details,
  });
}

final class InvalidResponseFailure extends Failure {
  const InvalidResponseFailure({
    required super.source,
    super.details,
  });
}

final class RequestFailedFailure extends Failure {
  const RequestFailedFailure({
    required super.source,
    super.details,
  });
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    required super.source,
    super.details,
  });
}

final class RequestCancelledFailure extends Failure {
  const RequestCancelledFailure({
    required super.source,
    super.details,
  });
}

final class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.source,
    super.details,
  });
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
