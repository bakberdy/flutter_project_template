abstract final class AuthApiEndpoints {
  static const String login = '/auth/login';
  static const String verifyEmail = '/auth/verify-email';
  static const String refresh = '/auth/refresh';
  static const String sessions = '/auth/sessions';
  static const String logOut = '/auth/logout';
  static const String deviceNotifications = '/auth/device/notifications';

  static String sessionById(String sessionId) => '$sessions/$sessionId';
}
