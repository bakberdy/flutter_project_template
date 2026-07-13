import 'package:core/core.dart';
import 'package:admin_profile/src/features/sessions/domain/entities/session.dart';

abstract class SessionsRepository {
  FutureEither<PaginatedResponse<Session>> getSessions({
    required int pageNumber,
    required int limit,
    bool? isActive,
    ApiCancelToken? cancelToken,
  });
  FutureEither<void> revokeSession(String sessionId);
  FutureEither<void> revokeAllSessions();
}
