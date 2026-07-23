import 'package:core/core.dart';
import 'package:shared/shared.dart';

abstract class SessionsRepository {
  FutureEither<PaginatedResponse<UserSession>> getSessions({
    required int pageNumber,
    required int limit,
    bool? isActive,
    ApiCancelToken? cancelToken,
  });
  FutureEither<void> revokeSession(String sessionId);
  FutureEither<void> revokeAllSessions();
}
