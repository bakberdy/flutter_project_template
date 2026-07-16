abstract final class AdminAuthApiEndpoints {
  static const String login = '/auth/login';
  static const String verifyEmail = '/auth/verify-email';
  static const String refresh = '/auth/refresh';
  static const String deviceNotifications = '/auth/device/notifications';
  static const String sessions = '/auth/sessions';

  static String session(String sessionId) => '$sessions/$sessionId';
}
