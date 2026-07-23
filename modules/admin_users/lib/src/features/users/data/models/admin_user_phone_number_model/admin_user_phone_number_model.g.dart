// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks, document_ignores

part of 'admin_user_phone_number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserPhoneNumberModel _$AdminUserPhoneNumberModelFromJson(
  Map<String, dynamic> json,
) => AdminUserPhoneNumberModel(
  dialCode: json['dial_code'] as String,
  number: json['number'] as String,
  countryCode: json['country_code'] as String?,
);

Map<String, dynamic> _$AdminUserPhoneNumberModelToJson(
  AdminUserPhoneNumberModel instance,
) => <String, dynamic>{
  'country_code': instance.countryCode,
  'dial_code': instance.dialCode,
  'number': instance.number,
};
