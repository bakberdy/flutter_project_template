import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/auth/auth_verify_request.dart';

part 'auth_verify_request_model.g.dart';

@JsonSerializable()
class AuthVerifyRequestModel extends AuthVerifyRequest {
  const AuthVerifyRequestModel({
    required super.loginRequestId,
    required super.email,
    required super.code,
  });

  factory AuthVerifyRequestModel.fromEntity(AuthVerifyRequest entity) =>
      AuthVerifyRequestModel(
        loginRequestId: entity.loginRequestId,
        email: entity.email,
        code: entity.code,
      );

  factory AuthVerifyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AuthVerifyRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthVerifyRequestModelToJson(this);
}
