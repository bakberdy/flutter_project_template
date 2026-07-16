import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin_auth/src/features/auth/domain/usecases/get_admin_session_use_case.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late _MockAuthRepository repository;
  late GetAdminSessionUseCase useCase;

  setUp(() {
    repository = _MockAuthRepository();
    when(() => repository.hasSession()).thenAnswer((_) async => true);
    when(
      () => repository.getCurrentUser(),
    ).thenAnswer((_) async => Right<Failure, User>(_admin));
    when(() => repository.clearSession()).thenAnswer((_) async {});
    useCase = GetAdminSessionUseCase(repository);
  });

  test(
    'returns unauthenticated without requesting user when session is absent',
    () async {
      when(() => repository.hasSession()).thenAnswer((_) async => false);

      final result = await useCase(const NoParams());

      final session = result.getOrElse(
        () => (user: _admin, accessDenied: true),
      );
      expect(session.user, isNull);
      expect(session.accessDenied, isFalse);
      verifyNever(() => repository.getCurrentUser());
    },
  );

  test('keeps session for an admin', () async {
    final result = await useCase(const NoParams());

    final session = result.getOrElse(() => (user: null, accessDenied: false));
    expect(session.user, _admin);
    expect(session.accessDenied, isFalse);
    verifyNever(() => repository.clearSession());
  });

  test('rejects regular users and clears their session', () async {
    when(
      () => repository.getCurrentUser(),
    ).thenAnswer((_) async => Right<Failure, User>(_regularUser));

    final result = await useCase(const NoParams());

    final session = result.getOrElse(() => (user: _admin, accessDenied: false));
    expect(session.user, isNull);
    expect(session.accessDenied, isTrue);
    verify(() => repository.clearSession()).called(1);
  });

  test(
    'does not convert current-user failures into an authenticated session',
    () async {
      const failure = Failure(source: 'users/me');
      when(
        () => repository.getCurrentUser(),
      ).thenAnswer((_) async => const Left<Failure, User>(failure));

      final result = await useCase(const NoParams());

      expect(result, const Left<Failure, AdminSessionResult>(failure));
      verifyNever(() => repository.clearSession());
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

class _MockAuthRepository extends Mock implements AuthRepository {}
