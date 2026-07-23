// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'auth_verify_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthVerifyResponseModel _$AuthVerifyResponseModelFromJson(
  Map<String, dynamic> json,
) => AuthVerifyResponseModel(
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String,
);

Map<String, dynamic> _$AuthVerifyResponseModelToJson(
  AuthVerifyResponseModel instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
};
