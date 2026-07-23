import 'package:json_annotation/json_annotation.dart';
import 'package:shared/src/entities/auth/auth_verify_response.dart';

part 'auth_verify_response_model.g.dart';

@JsonSerializable()
class AuthVerifyResponseModel extends AuthVerifyResponse {
  const AuthVerifyResponseModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthVerifyResponseModel.fromEntity(AuthVerifyResponse entity) =>
      AuthVerifyResponseModel(
        accessToken: entity.accessToken,
        refreshToken: entity.refreshToken,
      );

  factory AuthVerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthVerifyResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthVerifyResponseModelToJson(this);
}
