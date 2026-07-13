abstract final class AdminUsersApiEndpoints {
  static const String users = '/users';

  static String user(String userId) => '$users/$userId';

  static String profile(String userId) => '${user(userId)}/profile';

  static String status(String userId) => '${user(userId)}/status';

  static String role(String userId) => '${user(userId)}/role';

  static String approveDeletionRequest(String userId) =>
      '${user(userId)}/approve-deletion-request';
}
