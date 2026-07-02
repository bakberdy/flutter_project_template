import 'package:admin_auth/src/features/auth/domain/entities/verify_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authorization_verify_response_model.g.dart';

@JsonSerializable(createToJson: false)
class VerifyResponseModel extends VerifyResponse {
  const VerifyResponseModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyResponseModelFromJson(json);
}
