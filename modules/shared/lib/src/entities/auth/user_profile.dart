import 'package:equatable/equatable.dart';
import 'package:shared/src/entities/auth/user_phone_number.dart';

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
