import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/auth/user_phone_number.dart';

part 'user_phone_number_model.g.dart';

@JsonSerializable()
class UserPhoneNumberModel extends UserPhoneNumber {
  const UserPhoneNumberModel({
    required super.countryCode,
    required super.dialCode,
    required super.number,
  });

  factory UserPhoneNumberModel.fromJson(Map<String, dynamic> json) =>
      _$UserPhoneNumberModelFromJson(json);

  factory UserPhoneNumberModel.fromEntity(UserPhoneNumber phoneNumber) =>
      UserPhoneNumberModel(
        countryCode: phoneNumber.countryCode,
        dialCode: phoneNumber.dialCode,
        number: phoneNumber.number,
      );

  Map<String, dynamic> toJson() => _$UserPhoneNumberModelToJson(this);
}
