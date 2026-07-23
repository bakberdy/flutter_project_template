import 'package:admin_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_request_model.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class VerifyRequestModel {
  const VerifyRequestModel({
    required this.loginRequestId,
    required this.email,
    required this.code,
  });

  factory VerifyRequestModel.fromEntity(VerifyRequest request) =>
      VerifyRequestModel(
        loginRequestId: request.loginRequestId,
        email: request.email,
        code: request.code,
      );

  final String loginRequestId;
  final String email;
  final String code;

  Map<String, dynamic> toJson() => _$VerifyRequestModelToJson(this);
}
