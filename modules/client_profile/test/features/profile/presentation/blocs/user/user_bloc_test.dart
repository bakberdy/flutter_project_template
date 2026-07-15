import 'dart:async';

import 'package:client_profile/src/features/profile/domain/entities/user_avatar_upload.dart';
import 'package:client_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:client_profile/src/features/profile/domain/usecases/get_current_user_use_case.dart';
import 'package:client_profile/src/features/profile/presentation/blocs/user/user_bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  test(
    'logout cannot be overwritten by a late current-user response',
    () async {
      final repository = _ControllableUserProfileRepository();
      final bloc = UserBloc(GetCurrentUserUseCase(repository));
      addTearDown(bloc.close);

      bloc.add(const UserStartedEvent());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const UserLoggedOutEvent());
      await bloc.stream.firstWhere(
        (state) => state.status.isSuccess && state.user == null,
      );

      repository.currentUser.complete(Right(_user));
      await Future<void>.delayed(const Duration(milliseconds: 10));

      expect(bloc.state.user, isNull);
      expect(bloc.state.status.isSuccess, isTrue);
    },
  );
}

final _user = User(
  id: 'user-1',
  email: 'user@example.com',
  role: UserRole.user,
  status: UserStatus.active,
  isVerified: true,
  createdAt: DateTime.utc(2026),
  isUserDataUploaded: true,
);

class _ControllableUserProfileRepository implements UserProfileRepository {
  final Completer<Either<Failure, User>> currentUser = Completer();

  @override
  FutureEither<User> getCurrentUser({ApiCancelToken? cancelToken}) =>
      currentUser.future;

  @override
  FutureEither<UserProfile> createProfile({
    required String fullName,
    UserPhoneNumber? phoneNumber,
  }) => throw UnimplementedError();

  @override
  FutureEither<UserProfile> getCurrentProfile() => throw UnimplementedError();

  @override
  FutureEither<UserProfile> removeAvatar() => throw UnimplementedError();

  @override
  FutureEither<User> requestAccountDeletion() => throw UnimplementedError();

  @override
  FutureEither<UserProfile> updateAvatar(
    UserAvatarUpload avatar, {
    ApiProgressCallback? onSendProgress,
  }) => throw UnimplementedError();

  @override
  FutureEither<UserProfile> updateProfile({
    String? fullName,
    UserPhoneNumber? phoneNumber,
  }) => throw UnimplementedError();
}
