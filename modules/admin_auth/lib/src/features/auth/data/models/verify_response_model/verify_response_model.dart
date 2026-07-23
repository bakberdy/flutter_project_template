import 'package:admin_auth/src/features/auth/domain/entities/verify_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_response_model.g.dart';

@JsonSerializable()
class VerifyResponseModel extends VerifyResponse {
  const VerifyResponseModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyResponseModelFromJson(json);

  factory VerifyResponseModel.fromEntity(VerifyResponse entity) =>
      VerifyResponseModel(
        accessToken: entity.accessToken,
        refreshToken: entity.refreshToken,
      );

  Map<String, dynamic> toJson() => _$VerifyResponseModelToJson(this);
}
