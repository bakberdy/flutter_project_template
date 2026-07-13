abstract final class AdminProfileApiEndpoints {
  static const String me = '/users/me';
  static const String profile = '$me/profile';
  static const String avatar = '$me/avatar';
  static const String accountDeletion = '$me/delete-request';
  static const String sessions = '/auth/sessions';

  static String session(String sessionId) => '$sessions/$sessionId';
}
