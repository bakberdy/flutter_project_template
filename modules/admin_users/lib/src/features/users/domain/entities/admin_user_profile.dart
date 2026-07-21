import 'package:admin_users/src/features/users/domain/entities/admin_user_phone_number.dart';
import 'package:equatable/equatable.dart';

class AdminUserProfile extends Equatable {
  const AdminUserProfile({
    required this.userId,
    required this.fullName,
    required this.createdAt,
    required this.updatedAt,
    this.phoneNumber,
    this.avatarUrl,
    this.completedAt,
  });

  final String userId;
  final String fullName;
  final AdminUserPhoneNumber? phoneNumber;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;

  @override
  List<Object?> get props => [
    userId,
    fullName,
    phoneNumber,
    avatarUrl,
    createdAt,
    updatedAt,
    completedAt,
  ];
}
