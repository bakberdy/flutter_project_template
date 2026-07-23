import 'package:core/core.dart';
import 'package:shared/shared.dart';

abstract class AuthRepository {
  FutureEither<AuthLoginResponse> login(String email);
  FutureEither<AuthVerifyResponse> verify(AuthVerifyRequest request);
  FutureEither<AuthVerifyResponse> refreshToken();
}
