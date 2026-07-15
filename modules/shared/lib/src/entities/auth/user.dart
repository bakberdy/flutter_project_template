import 'package:equatable/equatable.dart';
import 'package:shared/src/entities/auth/user_role.dart';
import 'package:shared/src/entities/auth/user_status.dart';

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
