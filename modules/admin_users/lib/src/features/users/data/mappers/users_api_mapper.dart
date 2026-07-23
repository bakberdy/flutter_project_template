import 'package:admin_users/src/features/users/domain/entities/users_query.dart';
import 'package:shared/shared.dart';

extension AdminUserRoleApiMapper on UserRole {
  String get apiValue => switch (this) {
    UserRole.superAdmin => 'super_admin',
    UserRole.admin => 'admin',
    UserRole.user => 'user',
  };
}

extension AdminUserStatusApiMapper on UserStatus {
  String get apiValue => switch (this) {
    UserStatus.active => 'active',
    UserStatus.blocked => 'blocked',
    UserStatus.deletionRequested => 'deletion_requested',
    UserStatus.deleted => 'deleted',
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
