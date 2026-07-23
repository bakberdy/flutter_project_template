import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/auth/user_profile.dart';
import 'package:shared/src/models/auth/user_phone_number_model/user_phone_number_model.dart';

part 'user_profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.userId,
    required super.fullName,
    required super.createdAt,
    required super.updatedAt,
    UserPhoneNumberModel? phoneNumber,
    super.avatarUrl,
    super.completedAt,
  }) : super(phoneNumber: phoneNumber);

  factory UserProfileModel.fromEntity(UserProfile profile) => UserProfileModel(
    userId: profile.userId,
    fullName: profile.fullName,
    phoneNumber: profile.phoneNumber == null
        ? null
        : UserPhoneNumberModel.fromEntity(profile.phoneNumber!),
    avatarUrl: profile.avatarUrl,
    createdAt: profile.createdAt,
    updatedAt: profile.updatedAt,
    completedAt: profile.completedAt,
  );

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  @override
  UserPhoneNumberModel? get phoneNumber =>
      super.phoneNumber as UserPhoneNumberModel?;

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
