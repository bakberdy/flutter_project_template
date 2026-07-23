// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'auth_login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginRequestModel _$AuthLoginRequestModelFromJson(
  Map<String, dynamic> json,
) => AuthLoginRequestModel(
  email: json['email'] as String,
  device: AuthDeviceInfoModel.fromJson(json['device'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthLoginRequestModelToJson(
  AuthLoginRequestModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'device': instance.device.toJson(),
};
