abstract final class AdminAppNavigationPaths {
  static const signIn = '/sign-in';
  static const otp = '$signIn/otp';
  static const home = '/home';
  static const users = '$home/users';
  static String user(String userId) => '$users/$userId';
}
