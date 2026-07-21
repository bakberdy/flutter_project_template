import 'package:admin_users/src/features/users/data/models/admin_user_phone_number_model/admin_user_phone_number_model.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_user_profile_model.g.dart';

@AdminUserPhoneNumberModelConverter()
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class AdminUserProfileModel extends AdminUserProfile {
  const AdminUserProfileModel({
    required super.userId,
    required super.fullName,
    required super.createdAt,
    required super.updatedAt,
    super.phoneNumber,
    super.avatarUrl,
    super.completedAt,
  });

  factory AdminUserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUserProfileModelFromJson(json);
}
