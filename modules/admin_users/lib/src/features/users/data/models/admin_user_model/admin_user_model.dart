import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_user_model.g.dart';

@JsonSerializable()
class AdminUserModel extends AdminUser {
  const AdminUserModel({
    required super.id,
    required super.email,
    required super.role,
    required super.status,
    required super.isVerified,
    required super.createdAt,
    required super.isUserDataUploaded,
  });

  factory AdminUserModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUserModelFromJson(json);

  factory AdminUserModel.fromEntity(AdminUser entity) => AdminUserModel(
    id: entity.id,
    email: entity.email,
    role: entity.role,
    status: entity.status,
    isVerified: entity.isVerified,
    createdAt: entity.createdAt,
    isUserDataUploaded: entity.isUserDataUploaded,
  );

  Map<String, dynamic> toJson() => _$AdminUserModelToJson(this);
}
