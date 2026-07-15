import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/auth/user_profile.dart';
import 'package:shared/src/models/auth/user_phone_number_model/user_phone_number_model.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends UserProfile {
  @JsonKey(name: 'phone_number')
  final UserPhoneNumberModel? phoneNumberDto;

  const UserProfileModel({
    required super.userId,
    required super.fullName,
    this.phoneNumberDto,
    super.avatarUrl,
    required super.createdAt,
    required super.updatedAt,
    super.completedAt,
  }) : super(phoneNumber: phoneNumberDto);

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  factory UserProfileModel.fromEntity(UserProfile profile) => UserProfileModel(
    userId: profile.userId,
    fullName: profile.fullName,
    phoneNumberDto: profile.phoneNumber == null
        ? null
        : UserPhoneNumberModel.fromEntity(profile.phoneNumber!),
    avatarUrl: profile.avatarUrl,
    createdAt: profile.createdAt,
    updatedAt: profile.updatedAt,
    completedAt: profile.completedAt,
  );

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
