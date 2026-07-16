import 'dart:async';

import 'package:admin_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:admin_profile/src/features/profile/domain/usecases/get_current_user_use_case.dart';
import 'package:admin_profile/src/features/profile/domain/usecases/log_out_use_case.dart';
import 'package:admin_profile/src/features/profile/presentation/blocs/user/user_bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared/shared.dart';

void main() {
  test(
    'logout cannot be overwritten by a late current-user response',
    () async {
      final repository = _MockUserProfileRepository();
      final currentUser = Completer<Either<Failure, User>>();
      when(() => repository.hasSession()).thenAnswer((_) async => true);
      when(
        () => repository.getCurrentUser(cancelToken: any(named: 'cancelToken')),
      ).thenAnswer((_) => currentUser.future);
      when(
        () => repository.logOut(),
      ).thenAnswer((_) async => const Right<Failure, void>(null));
      final bloc = UserBloc(
        GetCurrentUserUseCase(repository),
        LogOutUseCase(repository),
      );
      addTearDown(bloc.close);

      bloc.add(const UserEvent.refreshUser());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const UserEvent.logout());
      await bloc.stream.firstWhere(
        (state) => state.status.isSuccess && state.user == null,
      );

      currentUser.complete(Right(_admin));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(bloc.state.user, isNull);
      expect(bloc.state.status.isSuccess, isTrue);
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

class _MockUserProfileRepository extends Mock
    implements UserProfileRepository {}
