import 'package:equatable/equatable.dart';

enum UserRole { superAdmin, admin, user }

enum UserStatus { active, blocked, deletionRequested, deleted }

class User extends Equatable {
  final String id;
  final String email;
  final UserRole role;
  final UserStatus status;
  final bool isVerified;
  final DateTime createdAt;
  final bool isUserDataUploaded;

  const User({
    required this.id,
    required this.email,
    required this.role,
    required this.status,
    required this.isVerified,
    required this.createdAt,
    required this.isUserDataUploaded,
  });

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
