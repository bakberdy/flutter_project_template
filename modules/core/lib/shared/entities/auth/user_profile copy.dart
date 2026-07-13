import 'package:client_auth/src/features/users/domain/entities/user_phone_number.dart';
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String userId;
  final String fullName;
  final UserPhoneNumber? phoneNumber;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;

  const UserProfile({
    required this.userId,
    required this.fullName,
    this.phoneNumber,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
  });

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
