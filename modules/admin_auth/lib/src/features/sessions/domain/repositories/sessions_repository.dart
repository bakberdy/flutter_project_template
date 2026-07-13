import 'package:core/core.dart';
import 'package:admin_auth/src/features/sessions/domain/entities/session.dart';

abstract class SessionsRepository {
  FutureEither<PaginatedResponse<Session>> getSessions({
    required int pageNumber,
    required int limit,
    bool? isActive,
  });
  FutureEither<void> revokeSession(String sessionId);
  FutureEither<void> revokeAllSessions();
}
