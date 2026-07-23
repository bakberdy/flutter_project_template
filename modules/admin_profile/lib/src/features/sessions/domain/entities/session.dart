import 'package:admin_profile/src/features/sessions/domain/entities/device.dart';
import 'package:equatable/equatable.dart';

class Session extends Equatable {
  const Session({
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
  final Device device;

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
