// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'auth_verify_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthVerifyRequestModel _$AuthVerifyRequestModelFromJson(
  Map<String, dynamic> json,
) => AuthVerifyRequestModel(
  loginRequestId: json['login_request_id'] as String,
  email: json['email'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$AuthVerifyRequestModelToJson(
  AuthVerifyRequestModel instance,
) => <String, dynamic>{
  'login_request_id': instance.loginRequestId,
  'email': instance.email,
  'code': instance.code,
};
