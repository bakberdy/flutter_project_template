import 'package:admin_profile/src/features/sessions/data/models/device_model/device_model.dart';
import 'package:admin_profile/src/features/sessions/domain/entities/session.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SessionModel extends Session {
  const SessionModel({
    required super.id,
    required super.userId,
    required super.refreshTokenHash,
    required super.createdAt,
    required super.expiresAt,
    required super.lastActive,
    required super.isRevoked,
    required DeviceModel device,
    super.revokedAt,
  }) : super(device: device);

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  factory SessionModel.fromEntity(Session entity) => SessionModel(
    id: entity.id,
    userId: entity.userId,
    refreshTokenHash: entity.refreshTokenHash,
    createdAt: entity.createdAt,
    expiresAt: entity.expiresAt,
    lastActive: entity.lastActive,
    isRevoked: entity.isRevoked,
    device: DeviceModel.fromEntity(entity.device),
    revokedAt: entity.revokedAt,
  );

  @override
  DeviceModel get device => super.device as DeviceModel;

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
