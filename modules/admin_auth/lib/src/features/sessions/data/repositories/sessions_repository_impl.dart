import 'package:admin_auth/src/features/sessions/data/datasources/sessions_remote_data_source.dart';
import 'package:admin_auth/src/features/sessions/domain/entities/session.dart';
import 'package:admin_auth/src/features/sessions/domain/repositories/sessions_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SessionsRepository)
class SessionsRepositoryImpl implements SessionsRepository {
  SessionsRepositoryImpl(this._remoteDataSource, this._tokenStorage);

  final SessionsRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;
  @override
  FutureEither<PaginatedResponse<Session>> getSessions({
    required int pageNumber,
    required int limit,
    bool? isActive,
  }) async {
    try {
      final result = await _remoteDataSource.getSessions(
        pageNumber: pageNumber,
        limit: limit,
        isActive: isActive,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.getSessions'));
    }
  }

  @override
  FutureEither<void> revokeSession(String sessionId) async {
    try {
      await _remoteDataSource.revokeSession(sessionId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.revokeSession'));
    }
  }

  @override
  FutureEither<void> revokeAllSessions() async {
    try {
      await _remoteDataSource.revokeAllSessions();
      await _tokenStorage.clearTokens();
      return const Right(null);
    } on Exception catch (e) {
      return Left(await e.toFailure(source: '$runtimeType.revokeAllSessions'));
    }
  }
}
