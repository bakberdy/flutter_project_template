import 'package:admin_auth/src/features/sessions/data/models/device_model/device_model.dart';
import 'package:admin_auth/src/features/sessions/domain/entities/session.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_model.g.dart';

@JsonSerializable(createToJson: false)
class SessionModel extends Session {
  const SessionModel({
    required super.id,
    required super.userId,
    required super.refreshTokenHash,
    required super.createdAt,
    required super.expiresAt,
    required super.lastActive,
    super.revokedAt,
    required super.isRevoked,
    required DeviceModel device,
  }) : super(device: device);

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);
}
