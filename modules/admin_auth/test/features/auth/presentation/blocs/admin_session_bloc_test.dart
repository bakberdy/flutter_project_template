import 'dart:async';

import 'package:admin_auth/src/features/auth/domain/entities/login_response.dart';
import 'package:admin_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:admin_auth/src/features/auth/domain/entities/verify_response.dart';
import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin_auth/src/features/auth/domain/usecases/auth_log_out_use_case.dart';
import 'package:admin_auth/src/features/auth/domain/usecases/get_admin_session_use_case.dart';
import 'package:admin_auth/src/features/auth/presentation/blocs/admin_session/admin_session_bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  test(
    'invalidation cannot be overwritten by a late session response',
    () async {
      final repository = _ControllableAuthRepository();
      final bloc = AdminSessionBloc(
        GetAdminSessionUseCase(repository),
        AuthLogOutUseCase(repository),
      );
      addTearDown(bloc.close);

      bloc.add(const AdminSessionStarted());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const AdminSessionInvalidated());
      await bloc.stream.firstWhere(
        (state) => state.status.isSuccess && !state.hasSession,
      );

      repository.currentUser.complete(Right(_admin));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(bloc.state.user, isNull);
      expect(bloc.state.hasSession, isFalse);
    },
  );
}

final _admin = User(
  id: 'admin-1',
  email: 'admin@example.com',
  role: UserRole.admin,
  status: UserStatus.active,
  isVerified: true,
  createdAt: DateTime.utc(2026),
  isUserDataUploaded: true,
);

class _ControllableAuthRepository implements AuthRepository {
  final Completer<Either<Failure, User>> currentUser = Completer();

  @override
  Future<bool> hasSession() async => true;

  @override
  FutureEither<User> getCurrentUser() => currentUser.future;

  @override
  Future<void> clearSession() async {}

  @override
  FutureEither<void> logOut() async => const Right(null);

  @override
  FutureEither<LoginResponse> login(String email) => throw UnimplementedError();

  @override
  FutureEither<VerifyResponse> refreshToken() => throw UnimplementedError();

  @override
  FutureEither<void> setNotificationToken(String token, String provider) =>
      throw UnimplementedError();

  @override
  FutureEither<VerifyResponse> verify(VerifyRequest request) =>
      throw UnimplementedError();
}
