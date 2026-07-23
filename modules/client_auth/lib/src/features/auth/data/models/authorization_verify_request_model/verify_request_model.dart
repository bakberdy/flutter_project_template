import 'package:client_auth/src/features/auth/domain/entities/verify_request.dart';

class VerifyRequestModel extends VerifyRequest {
  const VerifyRequestModel({
    required super.loginRequestId,
    required super.email,
    required super.code,
  });

  factory VerifyRequestModel.fromEntity(VerifyRequest request) =>
      VerifyRequestModel(
        loginRequestId: request.loginRequestId,
        email: request.email,
        code: request.code,
      );

  Map<String, dynamic> toJson() => {
    'login_request_id': loginRequestId,
    'email': email,
    'code': code,
  };
}
