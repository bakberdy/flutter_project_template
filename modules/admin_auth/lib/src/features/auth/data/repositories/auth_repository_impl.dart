import 'package:admin_auth/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:admin_auth/src/features/auth/data/models/authorization_verify_request_model/authorization_verify_request_model.dart';
import 'package:admin_auth/src/features/auth/domain/entities/auth_login_request.dart';
import 'package:admin_auth/src/features/auth/domain/entities/login_response.dart';
import 'package:admin_auth/src/features/auth/domain/entities/verify_request.dart';
import 'package:admin_auth/src/features/auth/domain/entities/verify_response.dart';
import 'package:admin_auth/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._tokenStorage);

  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;

  @override
  FutureEither<LoginResponse> login(String email) async {
    try {
      const device = AuthDeviceInfo(
        deviceId: 'web',
        os: 'web',
        osVersion: '',
        model: '',
        appVersion: '',
      );
      final request = AuthLoginRequest(email: email, device: device);
      final model = await _remoteDataSource.login(request);
      return Right(model);
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.login'));
    }
  }

  @override
  FutureEither<VerifyResponse> verify(VerifyRequest request) async {
    try {
      final model = await _remoteDataSource.verify(
        VerifyRequestModel.fromEntity(request),
      );
      await _tokenStorage.saveAccessToken(model.accessToken);
      await _tokenStorage.saveRefreshToken(model.refreshToken);
      return Right(model);
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.verify'));
    }
  }

  @override
  FutureEither<VerifyResponse> refreshToken() async {
    try {
      final refresh = await _tokenStorage.getRefreshToken();
      if (refresh == null) {
        throw Exception('Missing refresh token');
      }
      final model = await _remoteDataSource.refreshToken(refresh);
      await _tokenStorage.saveAccessToken(model.accessToken);
      await _tokenStorage.saveRefreshToken(model.refreshToken);
      return Right(model);
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.refreshToken'));
    }
  }

  @override
  FutureEither<void> setNotificationToken(String token, String provider) async {
    try {
      await _remoteDataSource.setNotificationToken(token, provider);
      return const Right(null);
    } on Exception catch (e) {
      return Left(
        await e.toFailure(source: '$runtimeType.setNotificationToken'),
      );
    }
  }
}
