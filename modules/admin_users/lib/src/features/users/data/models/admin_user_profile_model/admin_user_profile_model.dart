import 'package:admin_users/src/features/users/data/models/admin_user_phone_number_model/admin_user_phone_number_model.dart';
import 'package:admin_users/src/features/users/domain/entities/admin_user_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_user_profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AdminUserProfileModel extends AdminUserProfile {
  const AdminUserProfileModel({
    required super.userId,
    required super.fullName,
    required super.createdAt,
    required super.updatedAt,
    AdminUserPhoneNumberModel? phoneNumber,
    super.avatarUrl,
    super.completedAt,
  }) : super(phoneNumber: phoneNumber);

  factory AdminUserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUserProfileModelFromJson(json);

  factory AdminUserProfileModel.fromEntity(AdminUserProfile entity) =>
      AdminUserProfileModel(
        userId: entity.userId,
        fullName: entity.fullName,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        phoneNumber: entity.phoneNumber == null
            ? null
            : AdminUserPhoneNumberModel.fromEntity(entity.phoneNumber!),
        avatarUrl: entity.avatarUrl,
        completedAt: entity.completedAt,
      );

  @override
  AdminUserPhoneNumberModel? get phoneNumber =>
      super.phoneNumber as AdminUserPhoneNumberModel?;

  Map<String, dynamic> toJson() => _$AdminUserProfileModelToJson(this);
}
