// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_phone_number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPhoneNumberModel _$UserPhoneNumberModelFromJson(
  Map<String, dynamic> json,
) => UserPhoneNumberModel(
  countryCode: json['country_code'] as String,
  dialCode: json['dial_code'] as String,
  number: json['number'] as String,
);

Map<String, dynamic> _$UserPhoneNumberModelToJson(
  UserPhoneNumberModel instance,
) => <String, dynamic>{
  'country_code': instance.countryCode,
  'dial_code': instance.dialCode,
  'number': instance.number,
};
