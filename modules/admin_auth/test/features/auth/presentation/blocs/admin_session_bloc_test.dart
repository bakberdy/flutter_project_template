import 'dart:async';

import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin_auth/src/features/auth/domain/usecases/auth_log_out_use_case.dart';
import 'package:admin_auth/src/features/auth/domain/usecases/get_admin_session_use_case.dart';
import 'package:admin_auth/src/features/auth/presentation/blocs/admin_session/admin_session_bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared/shared.dart';

void main() {
  test(
    'invalidation cannot be overwritten by a late session response',
    () async {
      final repository = _MockAuthRepository();
      final currentUser = Completer<Either<Failure, User>>();
      when(() => repository.hasSession()).thenAnswer((_) async => true);
      when(
        () => repository.getCurrentUser(),
      ).thenAnswer((_) => currentUser.future);
      when(() => repository.clearSession()).thenAnswer((_) async {});
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

      currentUser.complete(Right(_admin));
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

class _MockAuthRepository extends Mock implements AuthRepository {}
