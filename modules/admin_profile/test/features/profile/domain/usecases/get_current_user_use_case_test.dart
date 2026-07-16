import 'package:admin_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:admin_profile/src/features/profile/domain/usecases/get_current_user_use_case.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared/shared.dart';

void main() {
  late _MockUserProfileRepository repository;
  late GetCurrentUserUseCase useCase;

  setUp(() {
    repository = _MockUserProfileRepository();
    when(() => repository.hasSession()).thenAnswer((_) async => true);
    when(
      () => repository.getCurrentUser(cancelToken: any(named: 'cancelToken')),
    ).thenAnswer((_) async => Right<Failure, User>(_admin));
    when(() => repository.clearSession()).thenAnswer((_) async {});
    useCase = GetCurrentUserUseCase(repository);
  });

  test(
    'returns unauthenticated without requesting user when session is absent',
    () async {
      when(() => repository.hasSession()).thenAnswer((_) async => false);

      final result = await useCase(_params);

      final session = result.getOrElse(
        () => (user: _admin, accessDenied: true),
      );
      expect(session.user, isNull);
      expect(session.accessDenied, isFalse);
      verifyNever(
        () => repository.getCurrentUser(cancelToken: any(named: 'cancelToken')),
      );
    },
  );

  test('keeps session for an admin', () async {
    final result = await useCase(_params);

    final session = result.getOrElse(() => (user: null, accessDenied: false));
    expect(session.user, _admin);
    expect(session.accessDenied, isFalse);
    verifyNever(() => repository.clearSession());
  });

  test('rejects regular users and clears their session', () async {
    when(
      () => repository.getCurrentUser(cancelToken: any(named: 'cancelToken')),
    ).thenAnswer((_) async => Right<Failure, User>(_regularUser));

    final result = await useCase(_params);

    final session = result.getOrElse(() => (user: _admin, accessDenied: false));
    expect(session.user, isNull);
    expect(session.accessDenied, isTrue);
    verify(() => repository.clearSession()).called(1);
  });

  test('does not convert current-user failures into a session', () async {
    const failure = Failure(source: 'users/me');
    when(
      () => repository.getCurrentUser(cancelToken: any(named: 'cancelToken')),
    ).thenAnswer((_) async => const Left<Failure, User>(failure));

    final result = await useCase(_params);

    expect(result, const Left<Failure, GetCurrentUserResult>(failure));
    verifyNever(() => repository.clearSession());
  });
}

const _params = (cancelToken: null, timeout: null);

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

class _MockUserProfileRepository extends Mock
    implements UserProfileRepository {}
