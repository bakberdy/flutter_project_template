// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'user_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDeviceModel _$UserDeviceModelFromJson(Map<String, dynamic> json) =>
    UserDeviceModel(
      os: json['os'] as String,
      osVersion: json['os_version'] as String,
      model: json['model'] as String,
      appVersion: json['app_version'] as String,
      id: json['id'] as String?,
      deviceId: json['device_id'] as String?,
      clientDeviceId: json['client_device_id'] as String?,
      pushProvider: json['push_provider'] as String?,
      pushToken: json['push_token'] as String?,
      hasNotificationToken: json['has_notification_token'] as bool?,
    );

Map<String, dynamic> _$UserDeviceModelToJson(UserDeviceModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'device_id': ?instance.deviceId,
      'client_device_id': ?instance.clientDeviceId,
      'os': instance.os,
      'os_version': instance.osVersion,
      'model': instance.model,
      'app_version': instance.appVersion,
      'push_provider': ?instance.pushProvider,
      'push_token': ?instance.pushToken,
      'has_notification_token': ?instance.hasNotificationToken,
    };
