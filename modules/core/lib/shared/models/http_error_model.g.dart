// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpErrorModel _$HttpErrorModelFromJson(Map<String, dynamic> json) =>
    HttpErrorModel(
      message: json['message'] as String,
      code: (json['code'] as num).toInt(),
      details: HttpErrorModel._detailsFromJson(json['details']),
    );

HttpErrorDetailsModel _$HttpErrorDetailsModelFromJson(
  Map<String, dynamic> json,
) => HttpErrorDetailsModel(
  statusCode: (json['status_code'] as num).toInt(),
  fieldErrors: (json['field_errors'] as List<dynamic>?)
      ?.map((e) => FieldErrorModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  type:
      $enumDecodeNullable(_$FailureTypeEnumMap, json['type']) ??
      FailureType.snackbar,
);

const _$FailureTypeEnumMap = {
  FailureType.snackbar: 'snackbar',
  FailureType.banner: 'banner',
  FailureType.inline: 'inline',
  FailureType.alert: 'alert',
  FailureType.fullScreen: 'full_screen',
  FailureType.silent: 'silent',
};

FieldErrorModel _$FieldErrorModelFromJson(Map<String, dynamic> json) =>
    FieldErrorModel(
      fieldName: json['field_name'] as String,
      message: json['message'] as String,
    );
