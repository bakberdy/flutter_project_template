abstract final class AdminAppNavigationPaths {
  static const root = '/';
  static const splashSegment = 'splash';
  static const homeSegment = 'home';
  static const dashboardSegment = '';

  static const home = '/$homeSegment';
  static const users = '$home/users';
  static String user(String userId) => '$users/$userId';
}
