abstract final class AdminAppNavigationPaths {
  static const signIn = '/sign-in';
  static const otp = '$signIn/otp';
  static const home = '/home';
  static const users = '$home/users';
  static String user(String userId) => '$users/$userId';
  static const settings = '$home/settings';
  static const innerOneSegment = 'inner1';
  static const innerTwoSegment = 'inner2';
  static const innerOne = '$home/$innerOneSegment';
  static const innerTwo = '$home/$innerTwoSegment';
}
