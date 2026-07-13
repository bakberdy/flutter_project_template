abstract final class ClientProfileApiEndpoints {
  static const String sessions = '/auth/sessions';

  static String sessionById(String sessionId) => '$sessions/$sessionId';
}
