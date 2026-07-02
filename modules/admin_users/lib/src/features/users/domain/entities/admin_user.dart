import 'package:equatable/equatable.dart';

enum AdminUserRole { superAdmin, admin, user }

enum AdminUserStatus { active, blocked, deletionRequested, deleted }

class AdminUser extends Equatable {
  const AdminUser({
    required this.id,
    required this.email,
    required this.role,
    required this.status,
    required this.isVerified,
    required this.createdAt,
    required this.isUserDataUploaded,
  });

  final String id;
  final String email;
  final AdminUserRole role;
  final AdminUserStatus status;
  final bool isVerified;
  final DateTime createdAt;
  final bool isUserDataUploaded;

  @override
  List<Object?> get props => [
    id,
    email,
    role,
    status,
    isVerified,
    createdAt,
    isUserDataUploaded,
  ];
}
