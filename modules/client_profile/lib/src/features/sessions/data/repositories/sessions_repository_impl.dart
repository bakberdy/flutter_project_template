import 'package:client_profile/src/features/sessions/data/datasources/sessions_remote_data_source.dart';
import 'package:client_profile/src/features/sessions/domain/repositories/sessions_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@Singleton(as: SessionsRepository)
class SessionsRepositoryImpl implements SessionsRepository {
  SessionsRepositoryImpl(this._remoteDataSource, this._tokenStorage);

  final SessionsRemoteDataSource _remoteDataSource;
  final TokenStorage _tokenStorage;
  @override
  FutureEither<PaginatedResponse<UserSession>> getSessions({
    required int pageNumber,
    required int limit,
    bool? isActive,
    ApiCancelToken? cancelToken,
  }) async {
    try {
      final result = await _remoteDataSource.getSessions(
        pageNumber: pageNumber,
        limit: limit,
        isActive: isActive,
        cancelToken: cancelToken,
      );
      return Right(result);
    } on Exception catch (e) {
      if (e is ApiException && e.type == ApiExceptionType.cancel) {
        return Left(Failure.requestCancelled('$runtimeType.getSessions'));
      }
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
