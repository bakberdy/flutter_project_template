import 'package:equatable/equatable.dart';
import 'package:shared/src/entities/sessions/user_session_device.dart';

class UserSession extends Equatable {
  const UserSession({
    required this.id,
    required this.userId,
    required this.refreshTokenHash,
    required this.createdAt,
    required this.expiresAt,
    required this.lastActive,
    required this.isRevoked,
    required this.device,
    this.revokedAt,
  });

  final String id;
  final String userId;
  final String refreshTokenHash;
  final DateTime createdAt;
  final DateTime expiresAt;
  final DateTime lastActive;
  final DateTime? revokedAt;
  final bool isRevoked;
  final UserSessionDevice device;

  @override
  List<Object?> get props => [
    id,
    userId,
    refreshTokenHash,
    createdAt,
    expiresAt,
    lastActive,
    revokedAt,
    isRevoked,
    device,
  ];
}
