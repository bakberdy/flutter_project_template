// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'verify_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyResponseModel _$VerifyResponseModelFromJson(Map<String, dynamic> json) =>
    VerifyResponseModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$VerifyResponseModelToJson(
  VerifyResponseModel instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
};
