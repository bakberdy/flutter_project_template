abstract final class AdminAppNavigationPaths {
  static const signIn = '/sign-in';
  static const home = '/home';
  static const users = '$home/users';
  static String user(String userId) => '$users/$userId';
  static const settings = '$home/settings';
}
