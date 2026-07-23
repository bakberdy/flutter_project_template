import 'package:admin_users/src/features/users/domain/entities/admin_user_phone_number.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_user_phone_number_model.g.dart';

@JsonSerializable()
class AdminUserPhoneNumberModel extends AdminUserPhoneNumber {
  const AdminUserPhoneNumberModel({
    required super.dialCode,
    required super.number,
    super.countryCode,
  });

  factory AdminUserPhoneNumberModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUserPhoneNumberModelFromJson(json);

  factory AdminUserPhoneNumberModel.fromEntity(
    AdminUserPhoneNumber entity,
  ) => AdminUserPhoneNumberModel(
    dialCode: entity.dialCode,
    number: entity.number,
    countryCode: entity.countryCode,
  );

  Map<String, dynamic> toJson() => _$AdminUserPhoneNumberModelToJson(this);
}
