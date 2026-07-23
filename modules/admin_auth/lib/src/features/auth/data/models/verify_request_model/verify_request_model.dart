import 'package:admin_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_request_model.g.dart';

@JsonSerializable()
class VerifyRequestModel extends VerifyRequest {
  const VerifyRequestModel({
    required super.loginRequestId,
    required super.email,
    required super.code,
  });

  factory VerifyRequestModel.fromEntity(VerifyRequest entity) =>
      VerifyRequestModel(
        loginRequestId: entity.loginRequestId,
        email: entity.email,
        code: entity.code,
      );

  factory VerifyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyRequestModelToJson(this);
}
