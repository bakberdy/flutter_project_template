import 'package:admin_auth/src/features/auth/domain/entities/login_response.dart';
import 'package:admin_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:admin_auth/src/features/auth/domain/entities/verify_response.dart';
import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin_auth/src/features/auth/domain/usecases/get_admin_session_use_case.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakeAuthRepository repository;
  late GetAdminSessionUseCase useCase;

  setUp(() {
    repository = _FakeAuthRepository();
    useCase = GetAdminSessionUseCase(repository);
  });

  test(
    'returns unauthenticated without requesting user when session is absent',
    () async {
      repository.hasActiveSession = false;

      final result = await useCase(const NoParams());

      final session = result.getOrElse(
        () => (user: _admin, accessDenied: true),
      );
      expect(session.user, isNull);
      expect(session.accessDenied, isFalse);
      expect(repository.currentUserRequests, 0);
    },
  );

  test('keeps session for an admin', () async {
    repository.currentUserResult = Right<Failure, User>(_admin);

    final result = await useCase(const NoParams());

    final session = result.getOrElse(() => (user: null, accessDenied: false));
    expect(session.user, _admin);
    expect(session.accessDenied, isFalse);
    expect(repository.clearSessionCalls, 0);
  });

  test('rejects regular users and clears their session', () async {
    repository.currentUserResult = Right<Failure, User>(_regularUser);

    final result = await useCase(const NoParams());

    final session = result.getOrElse(() => (user: _admin, accessDenied: false));
    expect(session.user, isNull);
    expect(session.accessDenied, isTrue);
    expect(repository.clearSessionCalls, 1);
  });

  test(
    'does not convert current-user failures into an authenticated session',
    () async {
      const failure = Failure(source: 'users/me');
      repository.currentUserResult = const Left<Failure, User>(failure);

      final result = await useCase(const NoParams());

      expect(result, const Left<Failure, AdminSessionResult>(failure));
      expect(repository.clearSessionCalls, 0);
    },
  );
}

final _admin = User(
  id: 'admin-id',
  email: 'admin@example.com',
  role: UserRole.admin,
  status: UserStatus.active,
  isVerified: true,
  createdAt: DateTime.utc(2026),
  isUserDataUploaded: true,
);

final _regularUser = User(
  id: 'user-id',
  email: 'user@example.com',
  role: UserRole.user,
  status: UserStatus.active,
  isVerified: true,
  createdAt: DateTime.utc(2026),
  isUserDataUploaded: true,
);

class _FakeAuthRepository implements AuthRepository {
  bool hasActiveSession = true;
  Either<Failure, User> currentUserResult = Right<Failure, User>(_admin);
  int currentUserRequests = 0;
  int clearSessionCalls = 0;

  @override
  Future<bool> hasSession() async => hasActiveSession;

  @override
  FutureEither<User> getCurrentUser() async {
    currentUserRequests++;
    return currentUserResult;
  }

  @override
  Future<void> clearSession() async {
    clearSessionCalls++;
  }

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
