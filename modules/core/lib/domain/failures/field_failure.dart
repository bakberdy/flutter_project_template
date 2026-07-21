import 'package:equatable/equatable.dart';

abstract class FieldFailure extends Equatable {
  const FieldFailure();
}

final class BackendFieldFailure extends FieldFailure {
  const BackendFieldFailure({
    required this.fieldName,
    required this.message,
  });

  final String fieldName;
  final String message;

  @override
  List<Object?> get props => [fieldName, message];
}
