import 'package:core/src/core/error/error.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_http_error_model.g.dart';

@JsonSerializable(createToJson: false)
class BaseHttpErrorModel {
  const BaseHttpErrorModel({
    required this.message,
    required this.code,
    this.details,
  });

  final String message;
  final int code;
  @JsonKey(fromJson: _detailsFromJson)
  final BaseHttpErrorDetailsModel? details;

  factory BaseHttpErrorModel.fromJson(Map<String, dynamic> json) =>
      _$BaseHttpErrorModelFromJson(json);

  static BaseHttpErrorDetailsModel? _detailsFromJson(Object? json) {
    if (json is Map<String, dynamic> && json['status_code'] != null) {
      if (json['attempts_left'] != null || json['blocked_until'] != null) {
        return AuthHttpErrorDetailsModel.fromJson(json);
      }
      return BaseHttpErrorDetailsModel.fromJson(json);
    }
    return null;
  }
}

@JsonSerializable(createToJson: false)
class BaseHttpErrorDetailsModel {
  const BaseHttpErrorDetailsModel({
    required this.statusCode,
    this.fieldErrors,
    this.type = FailureType.snackbar,
  });

  final int statusCode;
  final List<FieldErrorModel>? fieldErrors;
  final FailureType type;

  factory BaseHttpErrorDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BaseHttpErrorDetailsModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class AuthHttpErrorDetailsModel extends BaseHttpErrorDetailsModel {
  const AuthHttpErrorDetailsModel({
    required super.statusCode,
    super.fieldErrors,
    super.type,
    this.attemptsLeft,
    this.blockedUntil,
  });

  final int? attemptsLeft;
  final String? blockedUntil;

  factory AuthHttpErrorDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AuthHttpErrorDetailsModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class FieldErrorModel {
  const FieldErrorModel({required this.fieldName, required this.message});

  final String fieldName;
  final String message;

  factory FieldErrorModel.fromJson(Map<String, dynamic> json) =>
      _$FieldErrorModelFromJson(json);
}
