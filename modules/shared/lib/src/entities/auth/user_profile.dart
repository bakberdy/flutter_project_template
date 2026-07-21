import 'package:equatable/equatable.dart';
import 'package:shared/src/entities/auth/user_phone_number.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.userId,
    required this.fullName,
    required this.updatedAt,
    required this.createdAt,
    this.phoneNumber,
    this.avatarUrl,
    this.completedAt,
  });
  final String userId;
  final String fullName;
  final UserPhoneNumber? phoneNumber;
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
