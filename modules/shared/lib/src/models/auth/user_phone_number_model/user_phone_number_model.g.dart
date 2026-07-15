// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_phone_number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPhoneNumberModel _$UserPhoneNumberModelFromJson(
  Map<String, dynamic> json,
) => UserPhoneNumberModel(
  countryCode: json['countryCode'] as String,
  dialCode: json['dialCode'] as String,
  number: json['number'] as String,
);

Map<String, dynamic> _$UserPhoneNumberModelToJson(
  UserPhoneNumberModel instance,
) => <String, dynamic>{
  'countryCode': instance.countryCode,
  'dialCode': instance.dialCode,
  'number': instance.number,
};
