import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/sessions/user_session.dart';
import 'package:shared/src/models/sessions/user_session_device_model/user_session_device_model.dart';

part 'user_session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserSessionModel extends UserSession {
  const UserSessionModel({
    required super.id,
    required super.userId,
    required super.refreshTokenHash,
    required super.createdAt,
    required super.expiresAt,
    required super.lastActive,
    required super.isRevoked,
    required UserSessionDeviceModel device,
    super.revokedAt,
  }) : super(device: device);

  factory UserSessionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSessionModelFromJson(json);

  factory UserSessionModel.fromEntity(UserSession entity) => UserSessionModel(
    id: entity.id,
    userId: entity.userId,
    refreshTokenHash: entity.refreshTokenHash,
    createdAt: entity.createdAt,
    expiresAt: entity.expiresAt,
    lastActive: entity.lastActive,
    isRevoked: entity.isRevoked,
    device: UserSessionDeviceModel.fromEntity(entity.device),
    revokedAt: entity.revokedAt,
  );

  @override
  UserSessionDeviceModel get device => super.device as UserSessionDeviceModel;

  Map<String, dynamic> toJson() => _$UserSessionModelToJson(this);
}
