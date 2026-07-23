// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'auth_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginResponseModel _$AuthLoginResponseModelFromJson(
  Map<String, dynamic> json,
) => AuthLoginResponseModel(
  message: json['message'] as String,
  loginRequestId: json['login_request_id'] as String,
  otpExpiresIn: (json['otp_expires_in'] as num).toInt(),
);

Map<String, dynamic> _$AuthLoginResponseModelToJson(
  AuthLoginResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'login_request_id': instance.loginRequestId,
  'otp_expires_in': instance.otpExpiresIn,
};
