import 'package:admin_users/src/features/users/domain/entities/admin_user.dart';
import 'package:admin_users/src/features/users/domain/entities/users_query.dart';

extension AdminUserRoleApiMapper on AdminUserRole {
  String get apiValue => switch (this) {
    AdminUserRole.superAdmin => 'super_admin',
    AdminUserRole.admin => 'admin',
    AdminUserRole.user => 'user',
  };
}

extension AdminUserStatusApiMapper on AdminUserStatus {
  String get apiValue => switch (this) {
    AdminUserStatus.active => 'active',
    AdminUserStatus.blocked => 'blocked',
    AdminUserStatus.deletionRequested => 'deletion_requested',
    AdminUserStatus.deleted => 'deleted',
  };
}

extension UsersSortDirectionApiMapper on UsersSortDirection {
  String get apiValue => switch (this) {
    UsersSortDirection.ascending => 'asc',
    UsersSortDirection.descending => 'desc',
  };
}

extension UsersSortFieldApiMapper on UsersSortField {
  String get apiValue => switch (this) {
    UsersSortField.createdAt => 'created_at',
    UsersSortField.email => 'email',
    UsersSortField.role => 'role',
    UsersSortField.status => 'status',
    UsersSortField.isVerified => 'is_verified',
    UsersSortField.fullName => 'full_name',
    UsersSortField.phoneNumber => 'phone_number',
  };
}
