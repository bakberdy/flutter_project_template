import 'package:core/shared/entities/auth/user.dart';
import 'package:core/shared/entities/auth/user_role.dart';
import 'package:core/shared/entities/auth/user_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.role,
    required super.status,
    required super.isVerified,
    required super.createdAt,
    required super.isUserDataUploaded,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    role: user.role,
    status: user.status,
    isVerified: user.isVerified,
    createdAt: user.createdAt,
    isUserDataUploaded: user.isUserDataUploaded,
  );

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
