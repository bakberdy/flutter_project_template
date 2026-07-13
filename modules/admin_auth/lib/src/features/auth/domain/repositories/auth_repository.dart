import 'package:core/core.dart';
import 'package:admin_auth/src/features/auth/domain/entities/login_response.dart';
import 'package:admin_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:admin_auth/src/features/auth/domain/entities/verify_response.dart';

abstract class AuthRepository {
  Future<bool> hasSession();
  FutureEither<User> getCurrentUser();
  FutureEither<LoginResponse> login(String email);
  FutureEither<VerifyResponse> verify(VerifyRequest request);
  FutureEither<VerifyResponse> refreshToken();
  FutureEither<void> logOut();
  Future<void> clearSession();
  FutureEither<void> setNotificationToken(String token, String provider);
}
