import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_user_model.g.dart';

class AdminUserRoleJsonConverter
    implements JsonConverter<AdminUserRole, String> {
  const AdminUserRoleJsonConverter();

  @override
  AdminUserRole fromJson(String json) => switch (json) {
    'super_admin' => AdminUserRole.superAdmin,
    'admin' => AdminUserRole.admin,
    'user' => AdminUserRole.user,
    _ => throw ArgumentError.value(json, 'json', 'Unsupported user role'),
  };

  @override
  String toJson(AdminUserRole object) => switch (object) {
    AdminUserRole.superAdmin => 'super_admin',
    AdminUserRole.admin => 'admin',
    AdminUserRole.user => 'user',
  };
}

class AdminUserStatusJsonConverter
    implements JsonConverter<AdminUserStatus, String> {
  const AdminUserStatusJsonConverter();

  @override
  AdminUserStatus fromJson(String json) => switch (json) {
    'active' => AdminUserStatus.active,
    'blocked' => AdminUserStatus.blocked,
    'deletion_requested' => AdminUserStatus.deletionRequested,
    'deleted' => AdminUserStatus.deleted,
    _ => throw ArgumentError.value(json, 'json', 'Unsupported user status'),
  };

  @override
  String toJson(AdminUserStatus object) => switch (object) {
    AdminUserStatus.active => 'active',
    AdminUserStatus.blocked => 'blocked',
    AdminUserStatus.deletionRequested => 'deletion_requested',
    AdminUserStatus.deleted => 'deleted',
  };
}

@AdminUserRoleJsonConverter()
@AdminUserStatusJsonConverter()
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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
}
