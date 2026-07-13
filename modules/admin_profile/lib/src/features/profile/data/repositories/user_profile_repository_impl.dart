import 'package:core/core.dart';
import 'package:admin_profile/src/features/profile/data/datasources/user_profile_remote_data_source.dart';
import 'package:admin_profile/src/features/profile/domain/entities/user_avatar_upload.dart';
import 'package:admin_profile/src/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserProfileRepository)
class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource _remoteDataSource;
  UserProfileRepositoryImpl(this._remoteDataSource);

  @override
  FutureEither<UserProfile> getCurrentProfile() async {
    try {
      return Right(await _remoteDataSource.getCurrentProfile());
    } on ApiException catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.getCurrentProfile'));
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.getCurrentProfile'));
    }
  }

  @override
  FutureEither<UserProfile> createProfile({
    required String fullName,
    UserPhoneNumber? phoneNumber,
  }) async {
    try {
      return Right(
        await _remoteDataSource.createProfile(
          fullName: fullName,
          phoneNumber: phoneNumber == null
              ? null
              : UserPhoneNumberModel.fromEntity(phoneNumber),
        ),
      );
    } on ApiException catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.createProfile'));
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.createProfile'));
    }
  }

  @override
  FutureEither<UserProfile> updateProfile({
    String? fullName,
    UserPhoneNumber? phoneNumber,
  }) async {
    try {
      return Right(
        await _remoteDataSource.updateProfile(
          fullName: fullName,
          phoneNumber: phoneNumber == null
              ? null
              : UserPhoneNumberModel.fromEntity(phoneNumber),
        ),
      );
    } on ApiException catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.updateProfile'));
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.updateProfile'));
    }
  }

  @override
  FutureEither<UserProfile> updateAvatar(
    UserAvatarUpload avatar, {
    ApiProgressCallback? onSendProgress,
  }) async {
    try {
      return Right(
        await _remoteDataSource.updateAvatar(
          avatar,
          onSendProgress: onSendProgress,
        ),
      );
    } on ApiException catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.updateAvatar'));
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.updateAvatar'));
    }
  }

  @override
  FutureEither<UserProfile> removeAvatar() async {
    try {
      return Right(await _remoteDataSource.removeAvatar());
    } on ApiException catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.removeAvatar'));
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.removeAvatar'));
    }
  }

  @override
  FutureEither<User> requestAccountDeletion() async {
    try {
      return Right(await _remoteDataSource.requestAccountDeletion());
    } on ApiException catch (e) {
      return Left(
        await e.toFailure(source: '$runtimeType.requestAccountDeletion'),
      );
    } on Exception catch (e) {
      return Left(
        await e.toFailure(source: '$runtimeType.requestAccountDeletion'),
      );
    }
  }
}
