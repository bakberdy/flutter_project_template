import 'package:core/core.dart';
import 'package:client_auth/src/features/auth/domain/entities/login_response.dart';
import 'package:client_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:client_auth/src/features/auth/domain/entities/verify_response.dart';

abstract class AuthRepository {
  FutureEither<LoginResponse> login(String email);
  FutureEither<VerifyResponse> verify(VerifyRequest request);
  FutureEither<VerifyResponse> refreshToken();
}
