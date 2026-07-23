// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'auth_device_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDeviceInfoModel _$AuthDeviceInfoModelFromJson(Map<String, dynamic> json) =>
    AuthDeviceInfoModel(
      deviceId: json['device_id'] as String,
      os: json['os'] as String,
      osVersion: json['os_version'] as String,
      model: json['model'] as String,
      appVersion: json['app_version'] as String,
      pushProvider: json['push_provider'] as String?,
      pushToken: json['push_token'] as String?,
    );

Map<String, dynamic> _$AuthDeviceInfoModelToJson(
  AuthDeviceInfoModel instance,
) => <String, dynamic>{
  'device_id': instance.deviceId,
  'os': instance.os,
  'os_version': instance.osVersion,
  'model': instance.model,
  'app_version': instance.appVersion,
  'push_provider': ?instance.pushProvider,
  'push_token': ?instance.pushToken,
};
