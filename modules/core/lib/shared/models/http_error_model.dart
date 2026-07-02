import 'package:core/shared/entities/failure.dart';
import 'package:json_annotation/json_annotation.dart';

part 'http_error_model.g.dart';

@JsonSerializable(createToJson: false)
class HttpErrorModel {
  const HttpErrorModel({
    required this.message,
    required this.code,
    this.details,
  });

  final String message;
  final int code;
  @JsonKey(fromJson: _detailsFromJson)
  final HttpErrorDetailsModel? details;

  factory HttpErrorModel.fromJson(Map<String, dynamic> json) =>
      _$HttpErrorModelFromJson(json);

  static HttpErrorDetailsModel? _detailsFromJson(Object? json) {
    if (json is Map<String, dynamic> && json['status_code'] != null) {
      return HttpErrorDetailsModel.fromJson(json);
    }
    return null;
  }
}

@JsonSerializable(createToJson: false)
class HttpErrorDetailsModel {
  const HttpErrorDetailsModel({
    required this.statusCode,
    this.fieldErrors,
    this.type = FailureType.snackbar,
  });

  final int statusCode;
  final List<FieldErrorModel>? fieldErrors;
  final FailureType type;

  factory HttpErrorDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$HttpErrorDetailsModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class FieldErrorModel {
  const FieldErrorModel({required this.fieldName, required this.message});

  final String fieldName;
  final String message;

  factory FieldErrorModel.fromJson(Map<String, dynamic> json) =>
      _$FieldErrorModelFromJson(json);
}
