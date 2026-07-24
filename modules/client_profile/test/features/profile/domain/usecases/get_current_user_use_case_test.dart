import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/profile/domain/usecases/get_current_user_use_case.dart';
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
    when(repository.hasSession).thenAnswer((_) async => true);
    when(
      () => repository.getCurrentUser(cancelToken: any(named: 'cancelToken')),
    ).thenAnswer((_) async => Right<Failure, User>(_user));
    useCase = GetCurrentUserUseCase(repository);
  });

  test(
    'returns unauthenticated without requesting user when session is absent',
    () async {
      when(repository.hasSession).thenAnswer((_) async => false);

      final result = await useCase(_params);

      expect(result, const Right<Failure, User?>(null));
      verifyNever(
        () => repository.getCurrentUser(cancelToken: any(named: 'cancelToken')),
      );
    },
  );

  test('loads current user when session exists', () async {
    final result = await useCase(_params);

    expect(result, Right<Failure, User?>(_user));
    verify(
      () => repository.getCurrentUser(cancelToken: any(named: 'cancelToken')),
    ).called(1);
  });
}

const _params = (cancelToken: null, timeout: null);

final _user = User(
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
