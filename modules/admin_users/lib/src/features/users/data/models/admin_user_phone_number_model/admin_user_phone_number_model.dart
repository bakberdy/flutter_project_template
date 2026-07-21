import 'package:admin_users/src/features/users/domain/entities/admin_user_phone_number.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_user_phone_number_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class AdminUserPhoneNumberModel extends AdminUserPhoneNumber {
  const AdminUserPhoneNumberModel({
    required super.dialCode,
    required super.number,
    super.countryCode,
  });

  factory AdminUserPhoneNumberModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUserPhoneNumberModelFromJson(json);
}

class AdminUserPhoneNumberModelConverter
    implements JsonConverter<AdminUserPhoneNumber?, Map<String, dynamic>?> {
  const AdminUserPhoneNumberModelConverter();

  @override
  AdminUserPhoneNumber? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : AdminUserPhoneNumberModel.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AdminUserPhoneNumber? object) =>
      throw UnsupportedError('Admin user profiles are read-only');
}
