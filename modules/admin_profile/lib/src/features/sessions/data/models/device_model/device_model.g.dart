// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
  id: json['id'] as String,
  clientDeviceId: json['client_device_id'] as String,
  os: json['os'] as String,
  osVersion: json['os_version'] as String,
  model: json['model'] as String,
  appVersion: json['app_version'] as String,
  pushProvider: json['push_provider'] as String?,
  hasNotificationToken: json['has_notification_token'] as bool? ?? false,
);
